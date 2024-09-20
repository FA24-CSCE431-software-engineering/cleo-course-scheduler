require 'rails_helper'

RSpec.describe "StudentCourses", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/student_courses/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/student_courses/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/student_courses/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/student_courses/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/student_courses/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/student_courses/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/student_courses/destroy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /confirm_destroy" do
    it "returns http success" do
      get "/student_courses/confirm_destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
