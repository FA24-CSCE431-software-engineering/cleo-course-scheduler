# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Prerequisite, type: :prerequisites do
  before(:each) do
    @c1 = Course.create(crn: 1, cname: 'Discrete Structures for Computing')
    @c2 = Course.create(crn: 2, cname: 'Business Calculus')
  end

  context 'When creating a valid prerequisite' do
    it 'is valid with valid attributes' do
      pq = Prerequisite.create(course_crn: 1, prereq_crn: 2)
      expect(pq).to be_valid
    end
  end

  context 'When creating a invalid prerequisite' do
    it 'is invalid with invalid attributes' do
      pq = Prerequisite.create(course_crn: nil, prereq_crn: 2)
      expect(pq).to be_invalid
    end
  end

  context 'When creating a duplicate prerequisite' do
    it 'is invalid with duplicate course_crn, prereq_crn' do
      Prerequisite.create(course_crn: 1, prereq_crn: 2)
      pq2 = Prerequisite.new(course_crn: 1, prereq_crn: 2)
      expect(pq2).to be_invalid
    end
  end

  context 'When creating two prerequisite' do
    it 'is valid with unique course_crn, prereq_crn' do
      Course.create(crn: 3, cname: 'Calculus I for Biological Sciences')
      Prerequisite.create(course_crn: 1, prereq_crn: 2)
      pq2 = Prerequisite.new(course_crn: 1, prereq_crn: 3)
      expect(pq2).to be_valid
    end
  end
end
