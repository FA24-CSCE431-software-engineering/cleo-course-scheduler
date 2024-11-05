# frozen_string_literal: true

class Emphasis < ApplicationRecord
  # Validations
  validates :ename, presence: true, uniqueness: true
  validates :ename,
            format: { with: %r{\A[\w\s,/]+\z},
                      message: 'only alphanumeric characters, spaces, commas, and slashes are allowed' }

  # Course association
  has_many :course_emphases
  has_many :courses, through: :course_emphases
  has_many :students, foreign_key: :emphases_id
end
