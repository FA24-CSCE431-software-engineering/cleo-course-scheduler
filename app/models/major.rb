# frozen_string_literal: true

class Major < ApplicationRecord
  # Validations
  validates :mname, :cname, presence: true
  validates :mname, uniqueness: { scope: :cname }

  # Degree requirement associations
  has_and_belongs_to_many :courses
end
