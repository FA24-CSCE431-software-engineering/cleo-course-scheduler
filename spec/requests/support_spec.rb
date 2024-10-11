require 'rails_helper'

RSpec.describe "Supports", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get support_index_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /student" do
    it "returns http success" do
      get student_support_index_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin" do
    it "returns http success" do
      get admin_support_index_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /deployment" do
    it "returns http success" do
      get deployment_support_index_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /other" do
    it "returns http success" do
      get other_support_index_path
      expect(response).to have_http_status(:success)
    end
  end

end
