# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourseEmphasis, type: :model do
  before(:each) do
    @default_course = Course.create(ccode: 'CSCE', cnumber: 411, cname: 'Software Engineering', credit_hours: 3)
    @default_emphasis = Emphasis.create(ename: 'Math')
  end

  context 'When creating a valid course emphasis' do
    it 'is valid with valid attributes' do
      ce = CourseEmphasis.create(course: @default_course, emphasis: @default_emphasis)
      expect(ce).to be_valid
    end
  end

  context 'When creating an invalid course emphasis' do
    it 'is invalid with missing course_id' do
      ce = CourseEmphasis.create(emphasis: @default_emphasis)
      expect(ce).to be_invalid
    end
  end

  context 'When creating a duplicate course emphasis' do
    it 'is invalid with duplicate course_id, emphasis_id' do
      CourseEmphasis.create!(course: @default_course, emphasis: @default_emphasis)
      ce = CourseEmphasis.new(course: @default_course, emphasis: @default_emphasis)
      expect(ce).to be_invalid
    end
  end
end
