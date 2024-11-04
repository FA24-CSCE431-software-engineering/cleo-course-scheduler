# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DegreeRequirement, type: :degree_requirements do
  include_context 'models setup'

  context 'When creating a valid degree requirement' do
    it 'is valid with valid attributes' do
      expect(degree_requirement).to be_valid
    end
  end

  context 'When creating an invalid degree requirement' do
    it 'is invalid with missing course' do
      invalid_degree_req = DegreeRequirement.new(major: degree_requirement.major)
      expect(invalid_degree_req).to be_invalid
    end
  end

  context 'When creating an invalid degree requirement' do
    it 'is invalid with missing sem' do
      invalid_degree_req = DegreeRequirement.new(course: degree_requirement.course, major: degree_requirement.major)
      expect(invalid_degree_req).to be_invalid
    end
  end

  context 'When creating a duplicate degree requirement' do
    it 'is invalid with duplicate course, major' do
      dup_degree_req = DegreeRequirement.new(course: degree_requirement.course, major: degree_requirement.major,
                                             sem: degree_requirement.sem)
      expect(dup_degree_req).to be_invalid
    end
  end

  context 'When creating a two degree requirement' do
    it 'is valid with unique course_id, major_id' do
      unique_major = Major.create(mname: 'Computing', cname: 'College of Engineering')
      unique_degree_req = DegreeRequirement.create(course: degree_requirement.course, major: unique_major, sem: 1)
      expect(unique_degree_req).to be_valid
    end
  end
end
