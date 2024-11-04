# frozen_string_literal: true

class Major < ApplicationRecord
  # Validations
  validates :mname, :cname, presence: true
  validates :mname, uniqueness: { scope: :cname }
  validates :mname,
            format: { with: %r{\A[\w\s,/]+\z},
                      message: 'only alphanumeric characters, spaces, commas, and slashes are allowed' }

  # Degree requirement associations
  has_and_belongs_to_many :courses
  has_many :students
  has_many :degree_requirements
end
