# frozen_string_literal: true

class StudentLogin < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  has_one :student, foreign_key: :google_id, primary_key: :uid

  validates :uid, presence: true

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    create_with(uid:, full_name:, avatar_url:).find_or_create_by!(email:)
  end

  def is_admin?
    is_admin
  end
end
