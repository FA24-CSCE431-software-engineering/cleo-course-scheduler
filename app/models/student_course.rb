# frozen_string_literal: true

class StudentCourse < ApplicationRecord
    validates :student_id, presence: true
    validates :course_id, presence: true

    validates :course_id, uniqueness: { scope: :student_id }
end
