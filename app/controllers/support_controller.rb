class SupportController < ApplicationController
  
  # This bypass the authentication for testing purposes
  skip_before_action :authenticate_student_login! if Rails.env.test?

  def index
  end

  def student
  end

  def admin
  end

  def deployment
  end

  def other
  end
end
