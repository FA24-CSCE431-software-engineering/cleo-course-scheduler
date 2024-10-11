# frozen_string_literal: true

class Emphasis < ApplicationRecord
  # Validations
  validates :ename, presence: true, uniqueness: true

  # Course association
  has_many :course_emphases
  has_many :courses, through: :course_emphases
  has_many :students
end
