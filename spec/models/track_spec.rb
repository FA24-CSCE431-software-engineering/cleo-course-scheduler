# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Track, type: :track do
  context 'When creating a valid track' do
    it 'is valid with valid attributes' do
      track = Track.create(tname: 'Software')
      expect(track).to be_valid
    end
  end

  context 'When creating an invalid track' do
    it 'is invalid with missing tname' do
      track = Track.create(tname: '')
      expect(track).to be_invalid
    end
  end

  context 'When creating a duplicate track' do
    it 'is invalid with duplicate tname' do
      Track.create(tname: 'Software')
      t1 = Track.new(tname: 'Software')
      expect(t1).to be_invalid
    end
  end
end
