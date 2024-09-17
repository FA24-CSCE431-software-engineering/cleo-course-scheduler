class Emphasis < ApplicationRecord
    validates :crn, :ename, presence: true
    validates :crn, uniqueness: { scope: :ename }
    has_many :course, foreign_key: :crn
end