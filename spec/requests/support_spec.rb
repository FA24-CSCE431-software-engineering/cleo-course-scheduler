require 'rails_helper'

RSpec.describe "Supports", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/support/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /student" do
    it "returns http success" do
      get "/support/student"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin" do
    it "returns http success" do
      get "/support/admin"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /deployment" do
    it "returns http success" do
      get "/support/deployment"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /other" do
    it "returns http success" do
      get "/support/other"
      expect(response).to have_http_status(:success)
    end
  end

end
