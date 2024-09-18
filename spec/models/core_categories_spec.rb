# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoreCategories, type: :core_categories do
  before(:each) do
    @default_course = Course.create(ccode: 'CSCE', cnumber: 431, cname: 'Software Engineering', credit_hours: 3)
  end

  context 'When creating a valid category' do
    it 'is valid with valid attributes' do
      category = CoreCategories.create(course_id: @default_course.id, cname: 'Communication')
      expect(category).to be_valid
    end
  end

  context 'When creating an invalid category' do
    it 'is invalid with invalid attributes' do
      category = CoreCategories.create(course_id: @default_course.id, cname: '')
      expect(category).to be_invalid
    end
  end

  context 'When creating a duplicate category' do
    it 'is invalid with duplicate course_id, cname' do
      CoreCategories.create(course_id: @default_course.id, cname: 'Communication')
      c2 = CoreCategories.new(course_id: @default_course.id, cname: 'Communication')
      expect(c2).to be_invalid
    end
  end

  context 'When creating two category' do
    it 'is valid with unique course_id, cname' do
      CoreCategories.create(course_id: @default_course.id, cname: 'Communication')
      c2 = CoreCategories.create(course_id: @default_course.id, cname: 'Mathematics')
      expect(c2).to be_valid
    end
  end
end
