class Course < ApplicationRecord
    self.primary_key = :crn

    # validates :cname, presence: true
    # validates :credit_hours, presence: true
    # validates :credit_hours, :lecture_hours, :lab_hours, numericality: { only_integer: true }

    # Prerequisites associations
    has_many :prerequisites, foreign_key: :course_crn
    has_many :prerequisites_courses, through: :prerequisites, source: :prereq

    has_many :inverse_prerequisites, class_name: "Prerequisite", foreign_key: :prereq_crn
    has_many :prerequisite_courses, through: :inverse_prerequisites, source: :course

    # Degree plan associations
    has_and_belongs_to_many :students, join_table: :students_courses, foreign_key: "crn", association_foreign_key: "uin"

    # To add validation for length of crn and hours

end