require 'rails_helper'

RSpec.describe "CoreCategories", type: :request do
  describe "GET /_form" do
    it "returns http success" do
      get "/core_categories/_form"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /confirm_destroy" do
    it "returns http success" do
      get "/core_categories/confirm_destroy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/core_categories/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/core_categories/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/core_categories/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/core_categories/destroy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/core_categories/create"
      expect(response).to have_http_status(:success)
    end
  end

end
