# frozen_string_literal: true

class Course < ApplicationRecord
  # Validations
  validates :ccode, :cnumber, presence: true
  validates :credit_hours, :lecture_hours, :lab_hours, :cnumber, numericality: { only_integer: true }
  validates :ccode, length: { minimum: 4, maximimum: 30 }
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

  # Tracks association
  has_many :course_tracks
  has_many :tracks, through: :course_tracks

  # Core category association
  has_many :course_core_categories
  has_many :core_categories, through: :course_core_categories

  # Emphasis association
  has_many :course_emphases
  has_many :emphases, through: :course_emphases

  has_many :degree_requirements

  def prerequisite_groups
    prerequisites.includes(:prereq).group_by(&:equi_id).transform_values { |prereqs| prereqs.map(&:prereq) }
  end

  def full_title
    "#{ccode} #{cnumber}"
  end

end
