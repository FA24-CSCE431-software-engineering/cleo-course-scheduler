# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  context 'When creating a valid course' do
    it 'is valid with valid attributes' do
      course = Course.create(ccode: 'CSCE', cnumber: 411, cname: 'Software Engineering', credit_hours: 3)
      expect(course).to be_valid
    end
  end

  context 'When creating an invalid course' do
    it 'is invalid with missing attributes' do
      course = Course.create(ccode: 'CSCE')
      expect(course).to be_invalid
    end
  end

  context 'When creating a duplicate course' do
    it 'is invalid with duplicate ccode, cnumber' do
      Course.create(ccode: 'CSCE', cnumber: 411, cname: 'Software Engineering', credit_hours: 3)
      c2 = Course.new(ccode: 'CSCE', cnumber: 411, cname: 'Computer Organisation', credit_hours: 3)
      expect(c2).to be_invalid
    end
  end
end
