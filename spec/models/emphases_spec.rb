# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Emphasis, type: :emphases do
  include_context 'models setup'

  context 'When creating a valid emphasis' do
    it 'is valid with valid attributes' do
      expect(emphasis).to be_valid
    end
  end

  context 'When creating an invalid emphasis' do
    it 'is invalid with missing ename' do
      invalid_emphasis = Emphasis.create(ename: '')
      expect(invalid_emphasis).to be_invalid
    end
  end

  context 'When creating an invalid emphasis' do
    it 'is invalid with non alphanumeric name' do
      invalid_emphasis = Emphasis.create(ename: '!!')
      expect(invalid_emphasis).to be_invalid
    end
  end

  context 'When creating a duplicate emphasis' do
    it 'is invalid with duplicate ename' do
      dup_emphasis = Emphasis.new(ename: emphasis.ename)
      expect(dup_emphasis).to be_invalid
    end
  end
end
