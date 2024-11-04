# frozen_string_literal: true

# app/controllers/concerns/admin_authentication.rb
module AdminAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :require_admin
  end

  private

  def require_admin
    return if current_student_login&.is_admin?

    flash[:alert] = 'You are not authorized to access this page.'
    redirect_to student_dashboard_path(current_student_login.uid)
  end
end
