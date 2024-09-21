class StudentCoursesController < ApplicationController
  def index
    @student_courses = StudentCourse.where(uin: params[:uin])
  end

  def show
  end

  def new
  end

  def create
    @student_course = StudentCourse.new(student_course_params)
    if @student_course.save
      # handle successful save
    else
      # handle errors
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @student_course = StudentCourse.find(params[:id])
    @student_course.destroy
    # handle after delete, redirection etc.
  end

  def confirm_destroy
  end

  private

  def student_course_params
    params.require(:student_course).permit(:uin, :course_id)
  end

end
