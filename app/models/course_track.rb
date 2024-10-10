# frozen_string_literal: true

class CourseTrack < ApplicationRecord
  validates :year, presence: true

  belongs_to :course
  belongs_to :track

  validates :course_id, uniqueness: { scope: %i[track_id year] }

  before_validation :set_default_year, if: -> { year.nil? }

  private

  def set_default_year
    self.year = Time.current.year
  end
end
