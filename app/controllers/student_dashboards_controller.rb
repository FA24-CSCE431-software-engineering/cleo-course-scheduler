# frozen_string_literal: true

class StudentDashboardsController < ApplicationController
  before_action :set_student
  skip_before_action :authenticate_student_login! if Rails.env.test?
  def show; end

  private

  def current_year
    Time.current.year
  end

  def current_semester
    if Time.current.month >= 8 && Time.current.month <= 12
      'fall'
    else
      'spring'
    end
  end

  def set_student
    @student = Student.find_by(google_id: current_student_login.uid)

    return if @student

    redirect_to new_student_path(
      first_name: current_student_login.full_name.split.first,
      last_name: current_student_login.full_name.split.last,
      email: current_student_login.email,
      google_id: current_student_login.uid,
      enrol_year: current_year,
      grad_year: current_year + 4,
      enrol_semester: current_semester,
      grad_semester: current_semester == 'fall' ? 'spring' : 'fall'
    ) and return
  end
end
