class StudentCoursesController < ApplicationController
  before_action :set_student_course, only: [:edit, :update, :destroy, :confirm_destroy]

  def index
    if params[:student_id].present?
      @student = Student.find(params[:student_id])
      @student_courses = @student.student_courses
    else
      @student_courses = StudentCourse.none
    end
  
    @students = Student.all
  end

  def show
    @student_course = StudentCourse.find(params[:id])
  end

  def new
    @student_course = StudentCourse.new
  end

  def create
    @student_course = StudentCourse.new(student_course_params)
    if @student_course.save
      redirect_to student_courses_path(student_id: @student_course.student_id), notice: 'Course added successfully.'
    else
      flash.now[:alert] = @student_course.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    # @student_course = StudentCourse.find(params[:id])
  end

  def update
    # @student_course = StudentCourse.find(params[:id])
    if @student_course.update(student_course_params)
      redirect_to student_courses_path(student_id: @student_course.student_id), notice: 'Course updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    # @student_course = StudentCourse.find(params[:id])
    @student_course.destroy
    redirect_to student_courses_path(student_id: params[:student_id]), status: :see_other
  end

  def confirm_destroy
    # @student_course = StudentCourse.find(params[:id])
  end

  private

  def set_student_course
    @student_course = StudentCourse.find(params[:id])
  end

  def student_course_params
    params.require(:student_course).permit(:student_id, :course_id)
  end

end
