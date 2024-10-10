# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourseCoreCategory, type: :model do
  before(:each) do
    @default_course = Course.create(ccode: 'CSCE', cnumber: 411, cname: 'Software Engineering', credit_hours: 3)
    @default_core = CoreCategory.create(cname: 'Communication')
  end

  context 'When creating a valid course core category' do
    it 'is valid with valid attributes' do
      cc = CourseCoreCategory.create(course: @default_course, core_category: @default_core)
      expect(cc).to be_valid
    end
  end

  context 'When creating an invalid course core category' do
    it 'is invalid with missing course_id' do
      cc = CourseCoreCategory.create(core_category: @default_core)
      expect(cc).to be_invalid
    end
  end

  context 'When creating a duplicate course core category' do
    it 'is invalid with duplicate course_id, core_id' do
      CourseCoreCategory.create!(course: @default_course, core_category: @default_core)
      cc = CourseCoreCategory.new(course: @default_course, core_category: @default_core)
      expect(cc).to be_invalid
    end
  end
end
