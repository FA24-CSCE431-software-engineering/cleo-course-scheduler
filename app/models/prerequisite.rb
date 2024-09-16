class Prerequisite < ApplicationRecord
    primary_key = :course_crn

    belongs_to :course, foreign_key: :course_crn, class_name: "Course"
    belongs_to :prereq, foreign_key: :prereq_crn, class_name: "Course"

    validates :course_crn, :prereq_crn, presence: true
end