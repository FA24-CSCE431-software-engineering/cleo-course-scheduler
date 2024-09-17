# frozen_string_literal: true

class Emphasis < ApplicationRecord
  # Validations
  validates :crn, :ename, presence: true
  validates :crn, uniqueness: { scope: :ename }

  # Course association
  has_many :course, foreign_key: :crn
end
