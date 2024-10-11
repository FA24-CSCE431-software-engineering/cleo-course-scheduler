# frozen_string_literal: true

class StudentCourse < ApplicationRecord
  
  #self.primary_keys = :student_id, :course_id

  belongs_to :student
  belongs_to :course

  validates :student_id, presence: true
  validates :course_id, presence: true
  validates :sem, presence: true

  validates :course_id, uniqueness: { scope: :student_id, message: 'has already been added for this student.' }
end
