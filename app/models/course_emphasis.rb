# frozen_string_literal: true

class CourseEmphasis < ApplicationRecord
  belongs_to :course
  belongs_to :emphasis

  validates :course_id, uniqueness: { scope: :emphasis_id }
end
