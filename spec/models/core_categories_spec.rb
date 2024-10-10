# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoreCategory, type: :core_categories do
  context 'When creating a valid category' do
    it 'is valid with valid attributes' do
      c = CoreCategory.create(cname: 'Communication')
      expect(c).to be_valid
    end
  end

  context 'When creating an invalid category' do
    it 'is invalid with missing cname' do
      c = CoreCategory.create(cname: '')
      expect(c).to be_invalid
    end
  end

  context 'When creating a duplicate category' do
    it 'is invalid with duplicate cname' do
      CoreCategory.create(cname: 'Communication')
      c1 = CoreCategory.new(cname: 'Communication')
      expect(c1).to be_invalid
    end
  end
end
