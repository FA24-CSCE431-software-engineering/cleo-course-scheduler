# frozen_string_literal: true

class Track < ApplicationRecord
  # Validations
  validates :tname, presence: true, uniqueness: true

  # Track association
  # has_many :course, foreign_key: :course_id
end
