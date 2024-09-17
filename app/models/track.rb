# frozen_string_literal: true

class Track < ApplicationRecord
  # Validations
  validates :crn, :tname, presence: true
  validates :crn, uniqueness: { scope: :tname }

  # Track association
  has_many :course, foreign_key: :crn
end
