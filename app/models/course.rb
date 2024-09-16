class Course < ApplicationRecord
    self.primary_key = :crn

    validates :cname, presence: true
    validates :credit_hours, presence: true
    validates :credit_hours, :lecture_hours, :lab_hours, numericality: { only_integer: true }

    # To add validation for length of crn and hours

end