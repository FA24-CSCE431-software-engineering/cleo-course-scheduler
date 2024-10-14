# frozen_string_literal: true

class StudentDashboardsController < ApplicationController
  before_action :set_student
  def show; end

  private


  def set_student
    @student = Student.find(current_student_login.uid)
    unless @student
      redirect_to some_error_path, alert: "Student not found."
    end
  end


  
end
