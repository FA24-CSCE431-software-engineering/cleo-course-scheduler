# frozen_string_literal: true

class CoreCategories < ApplicationRecord
  # Validations
  validates :crn, :cname, presence: true
  validates :crn, uniqueness: { scope: :cname }

  # Course association
  has_many :course, foreign_key: :crn
end
