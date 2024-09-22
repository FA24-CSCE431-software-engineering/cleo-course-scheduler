# frozen_string_literal: true

class Course < ApplicationRecord
  # Validations
  validates :cname, :ccode, :cnumber, presence: true
  validates :credit_hours, presence: true
  validates :credit_hours, :lecture_hours, :lab_hours, :cnumber, numericality: { only_integer: true }
  validates :ccode, length: { is: 4 }
  validates :ccode, uniqueness: { scope: :cnumber }

  # Prerequisites associations
  has_many :prerequisites, foreign_key: :course_id
  has_many :prerequisites_courses, through: :prerequisites, source: :prereq

  has_many :inverse_prerequisites, class_name: 'Prerequisite', foreign_key: :prereq_id
  has_many :prerequisite_courses, through: :inverse_prerequisites, source: :course

  # Student courses associations
  has_and_belongs_to_many :students, through: :student_courses
  has_many :student_courses

  # Degree requirements associations
  has_and_belongs_to_many :majors
end
