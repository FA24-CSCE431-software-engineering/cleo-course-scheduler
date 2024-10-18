# frozen_string_literal: true

class DegreePlannersController < ApplicationController
  before_action :set_student
  skip_before_action :authenticate_student_login! if Rails.env.test?

  def show
    @default_plan = DegreeRequirement.includes(:course).where(major: @student.major)
    @student_courses = StudentCourse.includes(:course).where(student: @student).order(:sem)
  end

  def add_course
    @student_course = StudentCourse.new(student_id: current_student.id, course_id: params[:course_id],
                                        sem: params[:sem])

    if @student_course.save
      flash[:success] = 'Course added successfully!'
      redirect_to degree_planners_path
    else
      flash[:error] = 'Error adding course.'
      render :show
    end
  end

  def clear_courses
    @student_courses = StudentCourse.where(student: @student)
    @student_courses.destroy_all

    flash[:success] = 'All courses have been removed successfully!'

    redirect_to student_degree_planner_path(@student)
  end

  def set_default
    @student_courses = StudentCourse.where(student: @student)
    @student_courses.destroy_all

    degree_requirements = DegreeRequirement.where(major_id: @student.major_id)

    # Map the degree requirements to StudentCourse records
    degree_requirements.map do |requirement|
      StudentCourse.create(student: @student, course_id: requirement.course_id, sem: requirement.sem)
    end

    flash[:success] = 'Degree planner has been filled with courses from your major!'

    redirect_to student_degree_planner_path(@student)
  end

  def update_plan
    selected_course_id = params[:add_course].to_i
    semester = params[:sem].to_i

    if selected_course_id.positive? && semester.between?(1, 10)
      StudentCourse.find_or_create_by(student_id: @student.id, course_id: selected_course_id) do |sc|
        sc.sem = semester
      end
    else
      puts "Invalid course ID or semester value: Course ID - #{selected_course_id}, Semester - #{semester}"
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

  def generate_custom_plan; end

  def download_plan
    @student_courses = StudentCourse.where(student_id: @student.id).order(:sem)

    # Generate the CSV data
    csv_data = CSV.generate(headers: true) do |csv|
      # Define CSV headers
      csv << ['Course ID', 'Course Code', 'Course Number', 'Course Name', 'Credits', 'Semester']

      # Add each record as a row in the CSV
      # More data than required for uploading is downloaded for user's view
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
    @student_courses = StudentCourse.where(student: @student)
    @student_courses.destroy_all

    if params[:file].present?
      begin
        csv_file = CSV.read(params[:file].path, headers: true)
        expected_headers = ['Course ID', 'Course Code', 'Course Number', 'Course Name', 'Credits', 'Semester']

        # Checks if the headers are in the correct format
        if (csv_file.headers & expected_headers).size != expected_headers.size
          flash[:error] = "CSV format is incorrect. Please ensure the file has headers: #{expected_headers.join(', ')}."
          redirect_to student_degree_planner_path(@student) and return
        end

        # Read the uploaded CSV file
        CSV.foreach(params[:file].path, headers: true) do |row|
          course_data = {
            course_id: row['Course ID'],
            sem: row['Semester']
          }

          # Populates the student course table with uploaded courses
          StudentCourse.create(
            student: @student,
            course_id: course_data[:course_id],
            sem: course_data[:sem]
          )
        end
        flash[:success] = 'Degree plan uploaded successfully'
        redirect_to student_degree_planner_path(@student)

      # Catches exceptions when the file uploaded is not a csv
      rescue StandardError
        flash[:error] = 'The CSV file is malformed or unreadable. Please upload a valid CSV file.'
        redirect_to student_degree_planner_path(@student)
      end
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
end
