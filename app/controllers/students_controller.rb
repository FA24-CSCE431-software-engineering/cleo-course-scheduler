class StudentsController < ApplicationController
  before_action :set_student, only: %i[show edit update destroy]

  def index
    @students = Student.all
  end

  def show; end

  def new
    @student = Student.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      google_id: params[:google_id]
    )
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to students_path, notice: 'Student added successfully.'
    else
      render :new
    end
  end


  def edit; end


  def update
    if @student.update(student_params)
      redirect_to students_path, notice: 'Student updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @student.destroy
    redirect_to students_path, notice: 'Student deleted successfully.'
  end

  def confirm_destroy
    @student = Student.find(params[:id])
  end

  def profile
    @student = current_student_login
    @uid = @student.uid
  end

  def edit_profile
    # Check if the current student login has a corresponding student entry
    @student = Student.find_by(google_id: current_student_login.uid)

    # If the student entry does not exist, redirect to create a new one
    if @student.nil?
      if current_student_login.full_name.present?
        name_parts = current_student_login.full_name.split(" ", 2)
        @first_name = name_parts[0]
        @last_name = name_parts[1]
      else
        @first_name = ""
        @last_name = ""
      end

      # Redirect to new student page with pre-filled information
      redirect_to new_student_path(
        first_name: @first_name,
        last_name: @last_name,
        email: current_student_login.email,
        google_id: current_student_login.uid
      ) and return
    end
  end
  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:google_id, :first_name, :last_name, :email, :enrol_year, :grad_year, :enrol_semester,
                                    :grad_semester, :major_id, :emphasis_id, :track_id)
  end
end
