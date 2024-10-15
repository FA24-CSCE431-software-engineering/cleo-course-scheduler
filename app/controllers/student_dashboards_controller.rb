# frozen_string_literal: true

class StudentDashboardsController < ApplicationController
  before_action :set_student
  def show; end

  private


  def set_student
    @student = Student.find_by(google_id: current_student_login.uid)
    unless @student
      redirect_to new_student_path, alert: "Student not found."
    end

  end

  


  
end
