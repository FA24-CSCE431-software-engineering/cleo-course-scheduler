require 'rails_helper'

RSpec.describe "Admin::Majors", type: :request do
  let!(:major) { Major.create(cname: "Computer Science", mname: "CS") } # Create a Major for testing

  describe "GET /admin/majors" do
    it "returns http success" do
      get admin_majors_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin/majors/new" do
    it "returns http success" do
      get new_admin_major_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin/majors/:id/edit" do
    it "returns http success" do
      get edit_admin_major_path(major)
      expect(response).to have_http_status(:success)
    end
  end
=begin
  describe "GET /admin/majors/:id" do
    it "returns http success" do
      get admin_major_path(major)
      expect(response).to have_http_status(:success)
    end
  end
=end

  describe "POST /admin/majors" do
    context "with valid parameters" do
      it "creates a new major and redirects" do
        expect {
          post admin_majors_path, params: { major: { cname: "Mathematics", mname: "MATH" } }
        }.to change(Major, :count).by(1)

        expect(response).to redirect_to(admin_majors_path)
      end
    end

    context "with invalid parameters" do
      it "re-renders the new template" do
        post admin_majors_path, params: { major: { cname: "", mname: "" } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH /admin/majors/:id" do
    context "with valid parameters" do
      it "updates the major and redirects" do
        patch admin_major_path(major), params: { major: { cname: "Updated CS", mname: "Updated Major" } }
        expect(major.reload.cname).to eq("Updated CS")
        expect(response).to redirect_to(admin_majors_path)
      end
    end

    context "with invalid parameters" do
      it "re-renders the edit template" do
        patch admin_major_path(major), params: { major: { cname: "", mname: "" } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE /admin/majors/:id" do
    it "deletes the major and redirects" do
      delete admin_major_path(major)
      expect(response).to redirect_to(admin_majors_path)
      expect(Major.exists?(major.id)).to be_falsey
    end
  end

  describe "GET /admin/majors/:id/confirm_destroy" do
    it "returns http success" do
      get confirm_destroy_admin_major_path(major)
      expect(response).to have_http_status(:success)
    end
  end
end
