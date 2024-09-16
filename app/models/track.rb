class Track < ApplicationRecord
    validates :tname, presence: true
end