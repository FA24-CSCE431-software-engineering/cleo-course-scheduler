# frozen_string_literal: true

class CourseEmphasis < ApplicationRecord
  validates :year, presence: true

  belongs_to :course
  belongs_to :emphasis

  validates :course_id, uniqueness: { scope: %i[emphasis_id year] }

  before_validation :set_default_year, if: -> { year.nil? }

  private

  def set_default_year
    self.year = Time.current.year
  end
end
