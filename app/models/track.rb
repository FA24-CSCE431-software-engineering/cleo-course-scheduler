class Track < ApplicationRecord
    validates :crn, :tname, presence: true
    validates :crn, uniqueness: { scope: :tname }
    has_many :course, foreign_key: :crn
end