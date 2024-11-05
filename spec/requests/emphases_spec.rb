# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Emphases', type: :request do
  let!(:emphasis) { Emphasis.create(ename: 'Emphasis') } # Create a emphasis for testing

  # Students should not be able to view emphases
  describe 'GET admin/emphases/index' do
    include_context 'logged in student'
    it 'returns http redirect' do
      get admin_emphases_path
      expect(response).to have_http_status(:redirect)
    end
  end

  # Admins should be able to view emphases
  describe 'GET admin/emphases/index' do
    include_context 'logged in admin'
    it 'returns http success' do
      get admin_emphases_path
      expect(response).to have_http_status(:success)
    end
  end

  # Admins should be able to update a emphases
  describe 'GET /admin/emphases/:id' do
    include_context 'logged in admin'
    it 'returns http success' do
      get admin_emphasis_path(emphasis)
      expect(response).to have_http_status(:success)
    end
  end

  # Admins should be able to create a emphases
  describe 'POST /admin/emphases' do
    include_context 'logged in admin'
    context 'with valid parameters' do
      it 'creates a new emphasis and redirects' do
        expect do
          post admin_emphases_path, params: { emphasis: { ename: 'Mathematics' } }
        end.to change(Emphasis, :count).by(1)

        expect(response).to redirect_to(admin_emphases_path)
      end
    end

    context 'with invalid parameters' do
      it 're-renders the new template' do
        post admin_emphases_path, params: { emphasis: { ename: '' } }
        expect(response).to render_template(:index)
      end
    end
  end

  # Admins should be able to update a emphases
  describe 'PATCH /admin/emphases/:id' do
    include_context 'logged in admin'
    context 'with valid parameters' do
      it 'updates the emphasis and redirects' do
        patch admin_emphasis_path(emphasis), params: { emphasis: { ename: 'Updated Emphasis' } }

        emphasis.reload
        expect(emphasis.ename).to eq('Updated Emphasis')
        expect(response).to redirect_to(admin_emphases_path)
      end
    end

    context 'with invalid parameters' do
      it 're-renders the index template' do
        patch admin_emphasis_path(emphasis), params: { emphasis: { ename: '' } }
        expect(response).to render_template(:index)
      end
    end
  end

  # Admins should be able to delete a emphases
  describe 'DELETE /admin/emphases/:id' do
    include_context 'logged in admin'
    it 'deletes the emphasis and redirects' do
      delete admin_emphasis_path(emphasis)
      expect(response).to redirect_to(admin_emphases_path)
      expect(Emphasis.exists?(emphasis.id)).to be_falsey
    end
  end
end
