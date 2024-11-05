# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourseTrack, type: :model do
  include_context 'models setup'

  context 'When creating a valid course track' do
    it 'is valid with valid attributes' do
      expect(course_track).to be_valid
    end
  end

  context 'When creating an invalid course track' do
    it 'is invalid with missing course_id' do
      invalid_course_track = CourseTrack.create(track: course_track.track)
      expect(invalid_course_track).to be_invalid
    end
  end

  context 'When creating a duplicate course track' do
    it 'is invalid with duplicate course_id, track_id' do
      dup_course_track = CourseTrack.new(course: course_track.course, track: course_track.track)
      expect(dup_course_track).to be_invalid
    end
  end
end
