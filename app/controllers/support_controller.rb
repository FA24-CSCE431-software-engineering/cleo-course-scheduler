# frozen_string_literal: true

class SupportController < ApplicationController
  # This bypass the authentication for testing purposes
  before_action :set_student
  skip_before_action :authenticate_student_login! if Rails.env.test?

  def index; end

  def profile; end

  def viewDefaultPlan; end

  def buildPlan; end

  private

  def set_student
    @student = Student.find(current_student_login.uid)
    return if @student

    redirect_to some_error_path, alert: 'Student not found.'
  end
end
