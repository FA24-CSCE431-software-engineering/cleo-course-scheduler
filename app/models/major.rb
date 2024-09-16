class Major < ApplicationRecord
    validates :mname, :cname, presence: true
end