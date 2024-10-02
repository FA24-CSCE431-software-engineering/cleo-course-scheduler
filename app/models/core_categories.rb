# frozen_string_literal: true

class CoreCategories < ApplicationRecord
  # Validations
  validates :cname, presence: true, uniqueness: true
end
