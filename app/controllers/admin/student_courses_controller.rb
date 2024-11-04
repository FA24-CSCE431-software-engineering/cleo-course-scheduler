# frozen_string_literal: true

module Admin
  class StudentCoursesController < ApplicationController
    include AdminAuthentication

    before_action :set_student_course, only: %i[edit update destroy confirm_destroy]

    # This bypass the authentication for testing purposes
    skip_before_action :authenticate_student_login! if Rails.env.test?

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
      @student_course = StudentCourse.find_by!(student_id: params[:student_id].to_s, course_id: params[:course_id])
    end

    def new
      @student_course = StudentCourse.new
    end

    def create
      @student_course = StudentCourse.new(student_course_params)
      if @student_course.save
        redirect_to admin_student_courses_path(student_id: @student_course.student_id),
                    notice: 'Course added successfully.'
      else
        flash.now[:alert] = @student_course.errors.full_messages.join(', ')
        render :new
      end
    end

    def edit
      @student_course = StudentCourse.find_by!(
        student_id: params[:student_id].to_s,
        course_id: params[:course_id],
        sem: params[:sem]
      )
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_student_courses_path, alert: 'Student course not found.'
    end

    def update
      # @student_course = StudentCourse.find(params[:id])
      @student_course = set_student_course
      if @student_course.update(student_course_params)
        redirect_to admin_student_courses_path(student_id: @student_course.student_id),
                    notice: 'Course updated successfully.'
      else
        render :edit
      end
    end

    def destroy
      @student_course = set_student_course
      if @student_course
        @student_course.destroy
        redirect_to admin_student_courses_path(student_id: params[:student_id]),
                    status: :see_other, notice: 'Course removed successfully.'
      else
        redirect_to admin_student_courses_path, alert: 'Unable to remove course.'
      end
    end

    def confirm_destroy
      # @student_course = StudentCourse.find(params[:id])
    end

    private

    def set_student_course
      @student_course = StudentCourse.find_by!(student_id: params[:student_id].to_s, course_id: params[:course_id],
                                               sem: params[:sem])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'Student course not found.'
      redirect_to admin_student_courses_path
    end

    def student_course_params
      params.require(:student_course).permit(:student_id, :course_id, :sem)
    end
  end
end
