# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Track, type: :track do
  before(:each) do
    @default_course = Course.create(ccode: 'CSCE', cnumber: 411, cname: 'Software Engineering', credit_hours: 3)
  end

  context 'When creating a valid track' do
    it 'is valid with valid attributes' do
      track = Track.create(course_id: @default_course.id, tname: 'Software')
      expect(track).to be_valid
    end
  end

  context 'When creating an invalid track' do
    it 'is invalid with invalid attributes' do
      track = Track.create(course_id: @default_course.id, tname: '')
      expect(track).to be_invalid
    end
  end

  context 'When creating a duplicate track' do
    it 'is invalid with duplicate course_id, tname' do
      Track.create(course_id: @default_course.id, tname: 'Software')
      t2 = Track.new(course_id: @default_course.id, tname: 'Software')
      expect(t2).to be_invalid
    end
  end

  context 'When creating two tracks' do
    it 'is valid with unique course_id, tname' do
      Track.create(course_id: @default_course.id, tname: 'Software')
      t2 = Track.create(course_id: @default_course.id, tname: 'Systems')
      expect(t2).to be_valid
    end
  end
end
