# frozen_string_literal: true

class StudentDashboardsController < ApplicationController
  before_action :set_student
  def show; end

  private


  def set_student
    # Try to find the student by google_id
    @student = Student.find_by(google_id: current_student_login.uid)
  
    # If no student is found, create a new record using current_student_login info
    if @student.nil?
      @student = Student.create(
        google_id: current_student_login.uid,
        first_name: current_student_login.full_name.split(" ").first,
        last_name: current_student_login.full_name.split(" ").last,
        email: current_student_login.email,
        enrol_year: 2024,  # You might want to change this to dynamic values or handle this appropriately
        grad_year: 2028,   # Set appropriate default values or user input
        enrol_semester: "fall",  # Default or based on user input
        grad_semester: "spring",  # Default or based on user input
        major_id: 1 # Set default or appropriate value
      )
    end
  end
  


  
end
