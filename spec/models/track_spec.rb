# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Track, type: :track do
  before(:each) do
    @default_course = Course.create(crn: 1, cname: 'Software Engineering', credit_hours: 3)
  end

  context 'When creating a valid track' do
    it 'is valid with valid attributes' do
      track = Track.create(crn: 1, tname: 'Software')
      expect(track).to be_valid
    end
  end

  context 'When creating an invalid track' do
    it 'is invalid with invalid attributes' do
      track = Track.create(crn: 1, tname: '')
      expect(track).to be_invalid
    end
  end

  context 'When creating a duplicate track' do
    it 'is invalid with duplicate crn, tname' do
      Track.create(crn: 1, tname: 'Software')
      t2 = Track.new(crn: 1, tname: 'Software')
      expect(t2).to be_invalid
    end
  end

  context 'When creating two tracks' do
    it 'is valid with unique crn, tname' do
      Track.create(crn: 1, tname: 'Software')
      t2 = Track.create(crn: 1, tname: 'Systems')
      expect(t2).to be_valid
    end
  end
end
