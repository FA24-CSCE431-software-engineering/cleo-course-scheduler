# frozen_string_literal: true

class Emphasis < ApplicationRecord
  # Validations
  validates :ename, presence: true, uniqueness: true
end
