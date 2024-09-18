# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Emphasis, type: :emphases do
  before(:each) do
    @default_course = Course.create(crn: 1, cname: 'Software Engineering', credit_hours: 3)
  end

  context 'When creating a valid emphasis' do
    it 'is valid with valid attributes' do
      emphasis = Emphasis.create(crn: 1, ename: 'Economics')
      expect(emphasis).to be_valid
    end
  end

  context 'When creating an invalid emphasis' do
    it 'is invalid with invalid attributes' do
      emphasis = Emphasis.create(crn: 1, ename: '')
      expect(emphasis).to be_invalid
    end
  end

  context 'When creating a duplicate emphasis' do
    it 'is invalid with duplicate crn, ename' do
      Emphasis.create(crn: 1, ename: 'Economics')
      e2 = Emphasis.new(crn: 1, ename: 'Economics')
      expect(e2).to be_invalid
    end
  end

  context 'When creating two emphasis' do
    it 'is valid with unique crn, ename' do
      Emphasis.create(crn: 1, ename: 'Economics')
      e2 = Emphasis.create(crn: 1, ename: 'Math')
      expect(e2).to be_valid
    end
  end
end
