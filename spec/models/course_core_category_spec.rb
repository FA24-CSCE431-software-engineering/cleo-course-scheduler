# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourseCoreCategory, type: :model do
  include_context 'models setup'

  context 'When creating a valid course core category' do
    it 'is valid with valid attributes' do
      expect(course_core).to be_valid
    end
  end

  context 'When creating an invalid course core category' do
    it 'is invalid with missing course_id' do
      invalid_course_core = CourseCoreCategory.create(core_category: course_core.core_category)
      expect(invalid_course_core).to be_invalid
    end
  end

  context 'When creating a duplicate course core category' do
    it 'is invalid with duplicate course_id, core_id' do
      dup_course_core = CourseCoreCategory.new(course: course_core.course, core_category: course_core.core_category)
      expect(dup_course_core).to be_invalid
    end
  end
end
