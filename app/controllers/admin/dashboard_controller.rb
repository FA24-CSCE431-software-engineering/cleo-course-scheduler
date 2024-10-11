module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_student_login!
    before_action :ensure_admin!

    def show
      # Admin-specific logic goes here
    end

    private

    def ensure_admin!
      redirect_to root_path, alert: 'You are not authorized to view this page.' unless current_student_login.is_admin?
    end
  end
end
