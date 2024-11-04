# frozen_string_literal: true

class Track < ApplicationRecord
  # Validations
  validates :tname, presence: true, uniqueness: true
  validates :tname,
            format: { with: %r{\A[\w\s,/]+\z},
                      message: 'only alphanumeric characters, spaces, commas, and slashes are allowed' }

  # Course association
  has_many :course_tracks
  has_many :courses, through: :course_tracks
  has_many :students
end
