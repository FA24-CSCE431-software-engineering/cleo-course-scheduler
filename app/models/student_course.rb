# frozen_string_literal: true

class StudentCourse < ApplicationRecord
  # student added to fix delete issue
  belongs_to :student
  belongs_to :course

  validates :student_id, presence: true
  validates :course_id, presence: true
  validates :course_id, uniqueness: { scope: :student_id }
end
