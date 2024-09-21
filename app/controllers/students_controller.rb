class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
  end

  def new
    @student = Student.new
  end

  def create
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
  end

  def destroy
  end

  def confirm_destroy
  end

end
