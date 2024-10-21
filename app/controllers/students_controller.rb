class StudentsController < ApplicationController
  before_action :set_student, only: [:edit, :update, :show, :destroy]
  skip_before_action :authenticate_student_login! if Rails.env.test?

  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
    @tracks = Track.all.pluck(:tname) # Fetch track names
    @emphases = Emphasis.all.pluck(:ename) # Fetch emphasis names
  end

  def new
    @student = Student.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      google_id: params[:google_id],
      enrol_year: params[:enrol_year] || current_year,  # Set enrol_year or fallback to current year
      grad_year: params[:grad_year] || current_year + 4,
      enrol_semester: params[:enrol_semester] || current_semester,
      grad_semester: params[:grad_semester] || (current_semester == "fall" ? "spring" : "fall")
    )
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      # Query the DegreeRequirements table based on the student's major_id
      degree_requirements = DegreeRequirement.where(major_id: @student.major_id)

      # Map the degree requirements to StudentCourse records
      degree_requirements.map do |requirement|
        StudentCourse.create(student: @student, course_id: requirement.course_id, sem: requirement.sem)
      end

      if @student.is_admin?
        redirect_to students_path, notice: 'Student added successfully.'
      else
        redirect_to student_dashboard_path(@student.google_id), notice: 'Student added successfully.'
      end
    else
      render :new
    end
  end


  def edit; 
  end


  def update
    if @student.update(student_params)
      if current_student_login.is_admin?
        redirect_to edit_student_path(@student.google_id), notice: 'Student information updated successfully.'
      else
        redirect_to profile_student_path(current_student_login), notice: 'Your information has been updated successfully.'
      end
    else
      render :edit
    end
  end

  def destroy
    @student.destroy
    redirect_to students_path, notice: 'Student deleted successfully.'
  end

  def confirm_destroy
    Rails.logger.debug "Params: #{params.inspect}"
    @student = Student.find_by(google_id: params[:google_id])
    if @student.nil?
      redirect_to students_path, alert: "Student not found."
    end
  end
  

  def profile
    # @student = current_student_login
    # @uid = @student.uid
    @student = Student.find_by(google_id: current_student_login.uid)

    if @student.nil?
      redirect_to root_path, alert: "Student not found."
    end
  end

  


  private


  def set_student
    @student = Student.find_by(google_id: params[:google_id])
    if @student.nil?
      raise ActiveRecord::RecordNotFound, "Couldn't find Student with google_id=#{params[:google_id]}."
    end
  end

  

  def student_params
    params.require(:student).permit(:google_id, :first_name, :last_name, :email, :enrol_year, :grad_year, :enrol_semester,
                                    :grad_semester, :major_id, :emphasis_id)
  end


end
