# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourseTrack, type: :model do
  before(:each) do
    @default_course = Course.create(ccode: 'CSCE', cnumber: 411, cname: 'Software Engineering', credit_hours: 3)
    @default_track = Track.create(tname: 'Software')
  end

  context 'When creating a valid course track' do
    it 'is valid with valid attributes' do
      ct = CourseTrack.create(course: @default_course, track: @default_track)
      expect(ct).to be_valid
    end
  end

  context 'When creating an invalid course track' do
    it 'is invalid with missing course_id' do
      ct = CourseTrack.create(track: @default_track)
      expect(ct).to be_invalid
    end
  end

  context 'When creating a duplicate course track' do
    it 'is invalid with duplicate course_id, track_id' do
      CourseTrack.create!(course: @default_course, track: @default_track)
      ct = CourseTrack.new(course: @default_course, track: @default_track)
      expect(ct).to be_invalid
    end
  end
end
