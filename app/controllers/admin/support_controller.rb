# frozen_string_literal: true

module Admin
  class SupportController < ApplicationController
    include AdminAuthentication

    skip_before_action :authenticate_student_login! if Rails.env.test?

    def index; end

    def deployment; end

    def other; end
  end
end
