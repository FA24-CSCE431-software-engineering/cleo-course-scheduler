# frozen_string_literal: true

# spec/models/student_login_spec.rb

require 'rails_helper'

RSpec.describe StudentLogin, type: :model do
  describe 'validations' do
    it 'is valid with a uid' do
      student_login = StudentLogin.new(uid: '123456', email: 'test@example.com', full_name: 'Test User', avatar_url: 'http://example.com/avatar.png')
      expect(student_login).to be_valid
    end

    it 'is not valid without a uid' do
      student_login = StudentLogin.new(uid: nil, email: 'test@example.com', full_name: 'Test User', avatar_url: 'http://example.com/avatar.png')
      expect(student_login).not_to be_valid
      expect(student_login.errors[:uid]).to include("can't be blank")
    end
  end

  describe '.from_google' do
    let(:email) { 'test@example.com' }
    let(:full_name) { 'Test User' }
    let(:uid) { '123456' }
    let(:avatar_url) { 'http://example.com/avatar.png' }

    context 'when creating a new StudentLogin' do
      it 'creates a new StudentLogin when it does not exist' do
        expect do
          StudentLogin.from_google(email:, full_name:, uid:, avatar_url:)
        end.to change(StudentLogin, :count).by(1)

        student_login = StudentLogin.last
        expect(student_login.email).to eq(email)
        expect(student_login.full_name).to eq(full_name)
        expect(student_login.uid).to eq(uid)
        expect(student_login.avatar_url).to eq(avatar_url)
      end
    end

    context 'when finding an existing StudentLogin' do
      before do
        StudentLogin.create!(email:, full_name:, uid:, avatar_url:)
      end

      it 'does not create a new record' do
        expect do
          StudentLogin.from_google(email:, full_name:, uid:, avatar_url:)
        end.not_to change(StudentLogin, :count)
      end
    end
  end

  describe '#is_admin?' do
    it 'returns true if is_admin is true' do
      student_login = StudentLogin.new(is_admin: true)
      expect(student_login.is_admin?).to be true
    end

    it 'returns false if is_admin is false' do
      student_login = StudentLogin.new(is_admin: false)
      expect(student_login.is_admin?).to be false
    end
  end
end
