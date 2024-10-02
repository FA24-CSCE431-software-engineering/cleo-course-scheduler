# frozen_string_literal: true

class CourseTrack < ApplicationRecord
  belongs_to :course
  belongs_to :track

  validates :course_id, uniqueness: { scope: :track_id }
end
