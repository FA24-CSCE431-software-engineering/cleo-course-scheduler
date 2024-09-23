class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    @students = Student.all
  end

  def show
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to students_path
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @student.update(student_params)
      redirect_to profile_student_path(@student), notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @student.destroy
    redirect_to students_path
  end

  def confirm_destroy
    @student = Student.find(params[:id])
  end  

  def profile
    @student = current_student_login
    @uid = @student.uid
  end


  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:first_name, :last_name, :uin, :email, :major_id, :enrol_year, :grad_year, :enrol_semester, :grad_semester)
  end

  

end
