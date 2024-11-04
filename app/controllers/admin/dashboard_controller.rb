# frozen_string_literal: true

module Admin
  class DashboardController < ApplicationController
    include AdminAuthentication

    before_action :authenticate_student_login!

    def show; end
  end
end
