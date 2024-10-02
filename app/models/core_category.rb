# frozen_string_literal: true

class CoreCategory < ApplicationRecord
  # Validations
  validates :cname, presence: true, uniqueness: true

  # Course association
  has_many :course_core_categories
  has_many :courses, through: :course_core_categories
end
