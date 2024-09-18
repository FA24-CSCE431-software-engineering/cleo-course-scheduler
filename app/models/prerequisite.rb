# frozen_string_literal: true

class Prerequisite < ApplicationRecord
  # Validations
  validates :course_crn, :prereq_crn, presence: true
  validates :course_crn, uniqueness: { scope: :prereq_crn }

  # Prerequisites associations
  belongs_to :course, foreign_key: :course_crn, class_name: 'Course'
  belongs_to :prereq, foreign_key: :prereq_crn, class_name: 'Course'
end
