# frozen_string_literal: true

class DegreePlannerController < ApplicationController
  before_action :set_student
  skip_before_action :authenticate_student_login! if Rails.env.test?

  EXPECTED_HEADERS = ['Course ID', 'Course Code', 'Course Number', 'Course Name', 'Credits', 'Semester'].freeze

  def show
    @default_plan = DegreeRequirement.includes(:course).where(major: @student.major)
    @student_courses = StudentCourse.includes(:course).where(student: @student).order(:sem)
  end

  def add_course
    @student_course = StudentCourse.new(student_id: current_student.id, course_id: params[:course_id],
                                        sem: params[:sem])

    if @student_course.save
      flash[:success] = 'Course added successfully!'
      redirect_to degree_planner_path
    else
      flash[:error] = 'Error adding course.'
      render :show
    end
  end

  def clear_courses
    destroy_student_courses

    flash[:success] = 'All courses have been removed successfully!'
    redirect_to student_degree_planner_path(@student)
  end

  def set_default
    destroy_student_courses

    degree_requirements = DegreeRequirement.where(major_id: @student.major_id)
    add_student_course_records(degree_requirements)

    flash[:success] = 'Degree planner has been filled with courses from your major!'
    redirect_to student_degree_planner_path(@student)
  end

  def update_plan
    selected_course_id = params[:add_course].to_i
    semester = params[:sem].to_i
  
    if selected_course_id.positive? && semester.between?(1, 8)
      student_course = StudentCourse.new(student_id: @student.id, course_id: selected_course_id, sem: semester)
  
      if student_course.save
        flash[:success] = 'Course added successfully!'
      else
        flash[:error] = student_course.errors.full_messages.to_sentence
      end
    else
      flash[:error] = "Invalid course ID or semester value: Course ID - #{selected_course_id}, Semester - #{semester}"
    end
  
    redirect_to student_degree_planner_path(@student)
  end
  
  def remove_course
    student_course = StudentCourse.find_by(student_id: @student.id, course_id: params[:course_id])

    if student_course
      student_course.destroy
      flash[:success] = 'Course removed successfully!'
    else
      flash[:error] = 'Course not found in your planner.'
    end

    respond_to do |format|
      format.html { redirect_to student_degree_planner_path(@student) }
      format.json { head :no_content }
    end
  end

  # In DegreePlannerController
  def generate_custom_plan
    planner_service = DegreePlannerService.new(@student, params[:interests][:emphasis_area])
    planned_courses = planner_service.generate_plan
    
    # Clear existing courses
    destroy_student_courses
    
    # Create new student course records
    planned_courses.each do |course_info|
      StudentCourse.create!(
        student: @student,
        course: course_info[:course],
        sem: course_info[:semester]
      )
    end
    
    flash[:success] = 'Degree plan generated successfully!'
    redirect_to student_degree_planner_path(@student)
  end

  def download_plan
    @student_courses = StudentCourse.where(student_id: @student.id).order(:sem)

    # Generate the CSV data
    csv_data = CSV.generate(headers: true) do |csv|
      csv << EXPECTED_HEADERS

      # Add each record as a row in the CSV, not all are necessary for uploading
      @student_courses.each do |student_course|
        csv << [
          student_course.course.id,
          student_course.course.ccode,
          student_course.course.cnumber,
          student_course.course.cname,
          student_course.course.credit_hours,
          student_course.sem
        ]
      end
    end

    # Send the CSV file to the browser
    send_data csv_data, filename: "degree_plan_#{@student.id}.csv"
  end

  def upload_plan
    if params[:file].present?
      process_csv(params[:file])
    else
      flash[:error] = 'Please upload a CSV file.'
      redirect_to student_degree_planner_path(@student)
    end
  end

  private

  def set_student
    @student = Student.find(current_student_login.uid)
    return if @student

    redirect_to some_error_path, alert: 'Student not found.'
  end

  def generate_plan_based_on_interests(interests); end

  # Takes records and iteratively adds to student courses
  def add_student_course_records(records)
    records.map do |record|
      StudentCourse.create(student: @student, course_id: record.course_id, sem: record.sem)
    end
  end

  def destroy_student_courses
    @student.student_courses.destroy_all
  end

  # ======== Helper functions for uploading / downloading csv files ========
  def process_csv(file)
    csv_file = read_csv(file)

    if valid_csv?(csv_file)
      destroy_student_courses
      import_courses_from_csv(file)
      flash[:success] = 'Degree plan uploaded successfully'
    else
      flash[:error] = "CSV format is incorrect. Please ensure the file has headers: #{EXPECTED_HEADERS.join(', ')}."
    end

    redirect_to student_degree_planner_path(@student)
  rescue StandardError
    flash[:error] = 'The CSV file is malformed or unreadable. Please upload a valid CSV file.'
    redirect_to student_degree_planner_path(@student)
  end

  def read_csv(file)
    CSV.read(file.path, headers: true)
  end

  def valid_csv?(csv_file)
    (csv_file.headers & EXPECTED_HEADERS).size == EXPECTED_HEADERS.size
  end

  def import_courses_from_csv(file)
    CSV.foreach(file.path, headers: true) do |row|
      StudentCourse.create(
        student: @student,
        course_id: row['Course ID'],
        sem: row['Semester']
      )
    end
  end
  # ========================================================================
end
