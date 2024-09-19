# frozen_string_literal: true

class Prerequisite < ApplicationRecord
  # Validations
  validates :course_id, :prereq_id, presence: true
  validates :course_id, uniqueness: { scope: :prereq_id }

  # Prerequisites associations
  belongs_to :course, foreign_key: :course_id, class_name: 'Course'
  belongs_to :prereq, foreign_key: :prereq_id, class_name: 'Course'
end
