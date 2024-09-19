# frozen_string_literal: true

class Emphasis < ApplicationRecord
  # Validations
  validates :course_id, :ename, presence: true
  validates :course_id, uniqueness: { scope: :ename }

  # Course association
  has_many :course, foreign_key: :course_id
end
