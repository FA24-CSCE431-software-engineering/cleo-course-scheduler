class CoreCategories < ApplicationRecord
    validates :crn, :cname, presence: true
    validates :crn, uniqueness: { scope: :cname }
    has_many :course, foreign_key: :crn
end