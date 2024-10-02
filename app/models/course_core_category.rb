# frozen_string_literal: true

class CourseCoreCategory < ApplicationRecord
  belongs_to :course
  belongs_to :core_category

  validates :course_id, uniqueness: { scope: :core_category_id }
end
