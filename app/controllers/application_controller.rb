# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_student_login!

  helper_method :current_student

  private

  def current_student
    current_student_login
  end
end
