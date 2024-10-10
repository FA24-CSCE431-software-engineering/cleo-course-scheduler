# frozen_string_literal: true

class Prerequisite < ApplicationRecord
  # Validations
  validates :course_id, :prereq_id, :equi_id, presence: true
  validates :course_id, uniqueness: { scope: %i[prereq_id equi_id] }
  validates :equi_id, numericality: { only_integer: true }

  # Prerequisites associations
  belongs_to :course, foreign_key: :course_id, class_name: 'Course'
  belongs_to :prereq, foreign_key: :prereq_id, class_name: 'Course'
end
