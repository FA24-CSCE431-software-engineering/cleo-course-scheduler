# frozen_string_literal: true

class DegreeRequirement < ApplicationRecord
    validates :course_id, uniqueness: { scope: :major_id }
end
