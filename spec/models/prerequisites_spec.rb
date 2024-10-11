# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Prerequisite, type: :prerequisites do
  before(:each) do
    @c1 = Course.create(ccode: 'CSCE', cnumber: 222, cname: 'Discrete Structures for Computing', credit_hours: 3)
    @c2 = Course.create(ccode: 'MATH', cnumber: 142, cname: 'Business Calculus', credit_hours: 3)
  end

  context 'When creating a valid prerequisite' do
    it 'is valid with valid attributes' do
      pq = Prerequisite.create(course: @c1, prereq: @c2, equi_id: 1)
      expect(pq).to be_valid
    end
  end

  context 'When creating a invalid prerequisite' do
    it 'is invalid with missing course' do
      pq = Prerequisite.create(prereq: @c2, equi_id: 1)
      expect(pq).to be_invalid
    end
  end

  context 'When creating a invalid prerequisite' do
    it 'is invalid with missing eid' do
      pq = Prerequisite.create(course: @c1, prereq: @c2)
      expect(pq).to be_invalid
    end
  end

  context 'When creating a duplicate prerequisite' do
    it 'is invalid with duplicate course_id, prereq_id' do
      Prerequisite.create(course: @c1, prereq: @c2, equi_id: 1)
      pq2 = Prerequisite.new(course: @c1, prereq: @c2, equi_id: 1)
      expect(pq2).to be_invalid
    end
  end

  context 'When creating two prerequisite' do
    it 'is valid with unique course_id, prereq_id' do
      c3 = Course.create(ccode: 'MATH', cnumber: 147, cname: 'Calculus I for Biological Sciences', credit_hours: 3)
      Prerequisite.create(course: @c1, prereq: @c2, equi_id: 1)
      pq2 = Prerequisite.new(course: @c1, prereq: c3, equi_id: 1)
      expect(pq2).to be_valid
    end
  end
end
