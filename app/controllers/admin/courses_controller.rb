module Admin
  class CoursesController < ApplicationController
    before_action :set_course, only: %i[edit update destroy confirm_destroy]

    def confirm_destroy
      @course = Course.find(params[:id])
      render 'admin/courses/confirm_destroy'
    end

    def edit
      render 'admin/courses/edit'
    end

    def index
      @courses = Course.all
      render 'admin/courses/index'
    end

    def new
      @course = Course.new
      render 'admin/courses/new'
    end

    def destroy
      @course.destroy
      redirect_to admin_courses_path, notice: 'Course deleted succesfully.'
    end

    def create
      @course = Course.new(course_params)
      if @course.save
        redirect_to admin_courses_path, notice: 'Course added succesfully.'
      else
        render 'admin/courses/new'
      end
    end

    def show
      @course = Course.find(params[:id])
      render 'admin/courses/show'
    end

    def update
      if @course.update(course_params)
        redirect_to admin_courses_path, notice: 'Course updated successfully.'
      else
        render :edit
      end
    end

    private

    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:cnumber, :cname, :ccode, :description, :credit_hours, :lecture_hours, :lab_hours)  # are these enough?
    end
  end
end
