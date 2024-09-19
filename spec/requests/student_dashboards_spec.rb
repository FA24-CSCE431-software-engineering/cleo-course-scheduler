# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StudentDashboards', type: :request do
  it "returns http redirect and prints location" do
    get student_dashboard_path
    puts response.location  # This will print the redirect URL to the console
    expect(response).to have_http_status(:redirect)
  end
  
end
