# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Majors', type: :request do
  let!(:major) { Major.create(cname: 'Computer Science', mname: 'CS') } # Create a Major for testing

  # Students should not be able to view majors
  describe 'GET /admin/majors' do
    include_context 'logged in student'
    it 'returns http redirect' do
      get admin_majors_path
      expect(response).to have_http_status(:redirect)
    end
  end

  # Admins should be able to view majors
  describe 'GET /admin/majors' do
    include_context 'logged in admin'
    it 'returns http success' do
      get admin_majors_path
      expect(response).to have_http_status(:success)
    end
  end

  # Admins should be able to access creating a major
  describe 'GET /admin/majors/new' do
    include_context 'logged in admin'
    it 'returns http success' do
      get new_admin_major_path
      expect(response).to have_http_status(:success)
    end
  end

  # Admins should be able to update a major
  describe 'GET /admin/majors/:id/edit' do
    include_context 'logged in admin'
    it 'returns http success' do
      get edit_admin_major_path(major)
      expect(response).to have_http_status(:success)
    end
  end

  # Admins should be able to create a major
  describe 'POST /admin/majors' do
    include_context 'logged in admin'
    context 'with valid parameters' do
      it 'creates a new major and redirects' do
        expect do
          post admin_majors_path, params: { major: { cname: 'Mathematics', mname: 'MATH' } }
        end.to change(Major, :count).by(1)

        expect(response).to redirect_to(admin_majors_path)
      end
    end

    context 'with invalid parameters' do
      it 're-renders the new template' do
        post admin_majors_path, params: { major: { cname: '', mname: '' } }
        expect(response).to render_template(:new)
      end
    end
  end

  # Admins should be able to update a major
  describe 'PATCH /admin/majors/:id' do
    include_context 'logged in admin'
    context 'with valid parameters' do
      it 'updates the major and redirects' do
        patch admin_major_path(major), params: { major: { cname: 'Updated CS', mname: 'Updated Major' } }
        expect(major.reload.cname).to eq('Updated CS')
        expect(response).to redirect_to(admin_majors_path)
      end
    end

    context 'with invalid parameters' do
      it 're-renders the edit template' do
        patch admin_major_path(major), params: { major: { cname: '', mname: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  # Admins should be able to delete a major
  describe 'DELETE /admin/majors/:id' do
    include_context 'logged in admin'
    it 'deletes the major and redirects' do
      delete admin_major_path(major)
      expect(response).to redirect_to(admin_majors_path)
      expect(Major.exists?(major.id)).to be_falsey
    end
  end

  describe 'GET /admin/majors/:id/confirm_destroy' do
    include_context 'logged in admin'
    it 'returns http success' do
      get confirm_destroy_admin_major_path(major)
      expect(response).to have_http_status(:success)
    end
  end
end
