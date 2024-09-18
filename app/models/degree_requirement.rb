# frozen_string_literal: true

class DegreeRequirement < ApplicationRecord
  validates :course_id, presence: true
  validates :major_id, presence: true

  validates :course_id, uniqueness: { scope: :major_id }
end
