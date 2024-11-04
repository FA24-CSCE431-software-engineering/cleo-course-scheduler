# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  include_context 'models setup'

  context 'When creating a valid course' do
    it 'is valid with valid attributes' do
      expect(course).to be_valid
    end
  end

  context 'When creating an invalid course' do
    it 'is invalid with missing attributes' do
      invalid_course = Course.create(ccode: 'CSCE')
      expect(invalid_course).to be_invalid
    end
  end

  context 'When creating a duplicate course' do
    it 'is invalid with duplicate ccode, cnumber' do
      dup_course = Course.new(ccode: course.ccode, cnumber: course.cnumber, cname: 'Computer Organisation',
                              credit_hours: 3)
      expect(dup_course).to be_invalid
    end
  end
end
