class StudentCourse < ApplicationRecord
    validates :uin, :crn, presence: true
end