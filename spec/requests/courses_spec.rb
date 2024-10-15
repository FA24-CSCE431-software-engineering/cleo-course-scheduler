require 'rails_helper'
=begin
RSpec.describe "Courses", type: :request do
  describe "GET /_form" do
    it "returns http success" do
      get "/courses/_form"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /confirm_destroy" do
    it "returns http success" do
      get "/courses/confirm_destroy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/courses/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/courses/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/courses/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/courses/destroy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/courses/create"
      expect(response).to have_http_status(:success)
    end
  end

end
