# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Track, type: :track do
  include_context 'models setup'

  context 'When creating a valid track' do
    it 'is valid with valid attributes' do
      expect(track).to be_valid
    end
  end

  context 'When creating an invalid track' do
    it 'is invalid with missing tname' do
      invalid_track = Track.create(tname: '')
      expect(invalid_track).to be_invalid
    end
  end

  context 'When creating a duplicate track' do
    it 'is invalid with duplicate tname' do
      dup_track = Track.new(tname: track.tname)
      expect(dup_track).to be_invalid
    end
  end
end
