# frozen_string_literal: true

class Track < ApplicationRecord
  # Validations
  validates :course_id, :tname, presence: true
  validates :course_id, uniqueness: { scope: :tname }

  # Track association
  has_many :course, foreign_key: :course_id
end
