# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_student_login!
end
