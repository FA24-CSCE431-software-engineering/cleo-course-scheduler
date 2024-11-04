# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Supports', type: :request do
  # Students should be able to access the student support page
  describe 'GET support/index' do
    include_context 'logged in student'
    it 'returns http success' do
      get support_index_path
      expect(response).to have_http_status(:success)
    end
  end

  # Students should not be able to access the admin support page
  describe 'GET /admin/support/deployment' do
    include_context 'logged in student'
    it 'returns http failure' do
      get deployment_admin_support_index_path
      expect(response).to have_http_status(:redirect)
    end
  end

  # Admins should be able to access the admin support page
  describe 'GET /admin/support/index' do
    include_context 'logged in admin'
    it 'returns http success' do
      get admin_support_index_path
      expect(response).to have_http_status(:success)
    end
  end

  # Admins should be able to access the admin deployment support page
  describe 'GET /admin/support/deployment' do
    include_context 'logged in admin'
    it 'returns http success' do
      get deployment_admin_support_index_path
      expect(response).to have_http_status(:success)
    end
  end
end
