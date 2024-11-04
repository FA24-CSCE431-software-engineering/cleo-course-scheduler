# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourseEmphasis, type: :model do
  include_context 'models setup'

  context 'When creating a valid course emphasis' do
    it 'is valid with valid attributes' do
      expect(course_emphasis).to be_valid
    end
  end

  context 'When creating an invalid course emphasis' do
    it 'is invalid with missing course_id' do
      invalid_course_emphasis = CourseEmphasis.create(emphasis: course_emphasis.emphasis)
      expect(invalid_course_emphasis).to be_invalid
    end
  end

  context 'When creating a duplicate course emphasis' do
    it 'is invalid with duplicate course_id, emphasis_id' do
      dup_course_emphasis = CourseEmphasis.new(course: course_emphasis.course, emphasis: course_emphasis.emphasis)
      expect(dup_course_emphasis).to be_invalid
    end
  end
end
