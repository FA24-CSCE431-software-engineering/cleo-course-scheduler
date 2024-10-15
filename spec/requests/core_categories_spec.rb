
require 'rails_helper'

RSpec.describe "Admin::CoreCategories", type: :request do
  let!(:core_category) { CoreCategory.create!(cname: "Sample Category") }

  describe "GET /admin/core_categories" do
    it "returns http success" do
      get admin_core_categories_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin/core_categories/new" do
    it "returns http success" do
      get new_admin_core_category_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin/core_categories/:id/edit" do
    it "returns http success" do
      get edit_admin_core_category_path(core_category)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /admin/core_categories" do
    it "creates a core category and redirects" do
      post admin_core_categories_path, params: { core_category: { cname: "New Category" } }
      expect(response).to redirect_to(admin_core_categories_path)
    end
  end

  describe "DELETE /admin/core_categories/:id" do
    it "deletes the core category and redirects" do
      delete admin_core_category_path(core_category)
      expect(response).to redirect_to(admin_core_categories_path)
    end
  end

  describe "GET /admin/core_categories/:id/confirm_destroy" do
    it "returns http success" do
      get confirm_destroy_admin_core_category_path(core_category)
      expect(response).to have_http_status(:success)
    end
  end
end

