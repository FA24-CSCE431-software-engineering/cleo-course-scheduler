class Major < ApplicationRecord
    validates :mname, :cname, presence: true

    # Degree requirement associations
    has_and_belongs_to_many :courses
    
end