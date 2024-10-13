class DegreePlannersController < ApplicationController
  before_action :set_student

  # Show default or customized degree plan for the student
  def show
    # Fetch default degree plan for the student's major
    @default_plan = DegreeRequirement.includes(:course).where(major: @student.major)

    # Fetch the student's customized degree plan
    @student_courses = StudentCourse.includes(:course).where(student: @student).order(:sem)

    # Render default plan if no student plan exists
    @plan_to_display = @student_courses.present? ? @student_courses : @default_plan
  end

  def add_course
    @student_course = StudentCourse.new(student_id: current_student.id, course_id: params[:course_id], sem: params[:sem])
    
    if @student_course.save
      flash[:success] = "Course added successfully!"
      redirect_to degree_planners_path
    else
      flash[:error] = "Error adding course."
      render :show
    end
  end

  # Add or remove courses to/from student's degree plan
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
      flash[:success] = "Course removed successfully!"
    else
      flash[:error] = "Course not found in your planner."
    end
    
    respond_to do |format|
      format.html { redirect_to student_degree_planner_path(@student) } # Redirect for regular requests
      format.json { head :no_content } # Respond with no content for AJAX requests
    end
  end
  




  # Generate a custom degree planner based on student interests
  def generate_custom_plan
    interests = params[:interests]  # Assuming interests come from a form
    recommended_courses = generate_plan_based_on_interests(interests)

    # Save recommended courses into student courses table
    ActiveRecord::Base.transaction do
      recommended_courses.each do |course, sem|
        StudentCourse.find_or_create_by(student: @student, course: course, sem: sem)
      end
    end

    redirect_to degree_planner_path
  end

  def download_plan
    
  end
  
  
  

  private


  def set_student
    @student = Student.find(current_student_login.uid)
    unless @student
      redirect_to some_error_path, alert: "Student not found."
    end
  end

  def generate_plan_based_on_interests(interests)
    recommended_courses = []

    # Example: Get core courses for the major + filter by interests
    DegreeRequirement.where(major: @student.major).each do |req|
      if interests.include?(req.course.category)  # Assuming courses have categories based on interests
        recommended_courses << [req.course, req.sem]
      end
    end

    recommended_courses
  end

  

end
