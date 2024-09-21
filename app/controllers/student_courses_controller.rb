class StudentCoursesController < ApplicationController
  before_action :set_student_course, only: [:edit, :update, :destroy]

  def index
    @student_courses = StudentCourse.where(uin: params[:uin])
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
      redirect_to student_courses_path, notice: 'Course added successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @student_course.update(student_course_params)
      redirect_to student_courses_path, notice: 'Course updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @student_course.destroy
    redirect_to student_courses_path, notice: 'Course removed successfully.'
  end

  def confirm_destroy
  end

  private

  def set_student_course
    @student_course = StudentCourse.find(params[:id])
  end

  def student_course_params
    params.require(:student_course).permit(:student_id, :course_id)
  end

end
