# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Emphasis, type: :emphases do
  context 'When creating a valid emphasis' do
    it 'is valid with valid attributes' do
      e = Emphasis.create(ename: 'Math')
      expect(e).to be_valid
    end
  end

  context 'When creating an invalid emphasis' do
    it 'is invalid with missing ename' do
      e = Emphasis.create(ename: '')
      expect(e).to be_invalid
    end
  end

  context 'When creating a duplicate emphasis' do
    it 'is invalid with duplicate ename' do
      Emphasis.create(ename: 'Math')
      e1 = Emphasis.new(ename: 'Math')
      expect(e1).to be_invalid
    end
  end
end
