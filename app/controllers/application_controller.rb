# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_student_login!

  # Make Devise helper methods available in views
  helper_method :current_student

  private

  def current_student
    current_student_login
  end
end
