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
        expect {
          StudentLogin.from_google(email: email, full_name: full_name, uid: uid, avatar_url: avatar_url)
        }.to change(StudentLogin, :count).by(1)

        student_login = StudentLogin.last
        expect(student_login.email).to eq(email)
        expect(student_login.full_name).to eq(full_name)
        expect(student_login.uid).to eq(uid)
        expect(student_login.avatar_url).to eq(avatar_url)
      end
    end

    context 'when finding an existing StudentLogin' do
      before do
        StudentLogin.create!(email: email, full_name: full_name, uid: uid, avatar_url: avatar_url)
      end

      it 'does not create a new record' do
        expect {
          StudentLogin.from_google(email: email, full_name: full_name, uid: uid, avatar_url: avatar_url)
        }.not_to change(StudentLogin, :count)
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
