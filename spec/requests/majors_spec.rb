# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Majors', type: :request do
  describe 'GET /_form' do
    it 'returns http success' do
      get '/majors/_form'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /confirm_destroy' do
    it 'returns http success' do
      get '/majors/confirm_destroy'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get '/majors/edit'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/majors/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/majors/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/majors/destroy'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/majors/create'
      expect(response).to have_http_status(:success)
    end
  end
end
