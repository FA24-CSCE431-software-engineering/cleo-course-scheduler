# frozen_string_literal: true

class Track < ApplicationRecord
  # Validations
  validates :tname, presence: true, uniqueness: true

  # Course association
  has_many :course_tracks
  has_many :courses, through: :course_tracks
  has_many :students
end
