# frozen_string_literal: true

class CourseCoreCategory < ApplicationRecord
  validates :year, presence: true

  belongs_to :course
  belongs_to :core_category

  validates :course_id, uniqueness: { scope: %i[core_category_id year] }

  before_validation :set_default_year, if: -> { year.nil? }

  private

  def set_default_year
    self.year = Time.current.year
  end
end
