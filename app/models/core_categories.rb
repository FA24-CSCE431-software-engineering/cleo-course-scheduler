# frozen_string_literal: true

class CoreCategories < ApplicationRecord
  # Validations
  validates :course_id, :cname, presence: true
  validates :course_id, uniqueness: { scope: :cname }

  # Course association
  has_many :course, foreign_key: :course_id
end
