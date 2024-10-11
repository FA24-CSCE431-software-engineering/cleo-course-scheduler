# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DegreeRequirement, type: :degree_requirements do
  before(:each) do
    @default_course = Course.create(ccode: 'CSCE', cnumber: 411, cname: 'Software Engineering', credit_hours: 3)
    @default_major = Major.create(mname: 'Computer Science', cname: 'College of Engineering')
  end

  context 'When creating a valid degree requirement' do
    it 'is valid with valid attributes' do
      req = DegreeRequirement.create(course: @default_course, major: @default_major, sem: 1)
      expect(req).to be_valid
    end
  end

  context 'When creating an invalid degree requirement' do
    it 'is invalid with missing course' do
      req = DegreeRequirement.new(major: @default_major)
      expect(req).to be_invalid
    end
  end

  context 'When creating an invalid degree requirement' do
    it 'is invalid with missing sem' do
      req = DegreeRequirement.new(course: @default_course, major: @default_major)
      expect(req).to be_invalid
    end
  end

  context 'When creating a duplicate degree requirement' do
    it 'is invalid with duplicate course, major' do
      DegreeRequirement.create(course: @default_course, major: @default_major, sem: 1)
      r2 = DegreeRequirement.new(course: @default_course, major: @default_major, sem: 1)
      expect(r2).to be_invalid
    end
  end

  context 'When creating a two degree requirement' do
    it 'is valid with unique course_id, major_id' do
      major = Major.create(mname: 'Computing', cname: 'College of Engineering')
      DegreeRequirement.create(course: @default_course, major: @default_major, sem: 1)
      r2 = DegreeRequirement.create(course: @default_course, major:, sem: 1)
      expect(r2).to be_valid
    end
  end
end
