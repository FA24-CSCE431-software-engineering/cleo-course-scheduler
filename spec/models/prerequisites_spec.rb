# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Prerequisite, type: :prerequisites do
  before(:each) do
    @c1 = Course.create(ccode: 'CSCE', cnumber: 222, cname: 'Discrete Structures for Computing', credit_hours: 3)
    @c2 = Course.create(ccode: 'MATH', cnumber: 142, cname: 'Business Calculus', credit_hours: 3)
  end

  context 'When creating a valid prerequisite' do
    it 'is valid with valid attributes' do
      pq = Prerequisite.create(course_id: @c1.id, prereq_id: @c2.id)
      expect(pq).to be_valid
    end
  end

  context 'When creating a invalid prerequisite' do
    it 'is invalid with invalid attributes' do
      pq = Prerequisite.create(course_id: nil, prereq_id: @c2.id)
      expect(pq).to be_invalid
    end
  end

  context 'When creating a duplicate prerequisite' do
    it 'is invalid with duplicate course_id, prereq_id' do
      Prerequisite.create(course_id: @c1.id, prereq_id: @c2.id)
      pq2 = Prerequisite.new(course_id: @c1.id, prereq_id: @c2.id)
      expect(pq2).to be_invalid
    end
  end

  context 'When creating two prerequisite' do
    it 'is valid with unique course_id, prereq_id' do
      c3 = Course.create(ccode: 'MATH', cnumber: 147, cname: 'Calculus I for Biological Sciences', credit_hours: 3)
      Prerequisite.create(course_id: @c1.id, prereq_id: @c2.id)
      pq2 = Prerequisite.new(course_id: @c1.id, prereq_id: c3.id)
      expect(pq2).to be_valid
    end
  end
end
