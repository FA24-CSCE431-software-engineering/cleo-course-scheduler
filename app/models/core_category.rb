# frozen_string_literal: true

class CoreCategory < ApplicationRecord
  # Validations
  validates :cname, presence: true, uniqueness: true
  validates :cname,
            format: { with: %r{\A[\w\s,/]+\z},
                      message: 'only alphanumeric characters, spaces, commas, and slashes are allowed' }

  # Course association
  has_many :course_core_categories
  has_many :courses, through: :course_core_categories
end
