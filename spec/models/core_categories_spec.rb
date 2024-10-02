# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoreCategories, type: :core_categories do
  context 'When creating a valid category' do
    it 'is valid with valid attributes' do
      c = CoreCategories.create(cname: 'Communication')
      expect(c).to be_valid
    end
  end

  context 'When creating an invalid category' do
    it 'is invalid with missing cname' do
      c = CoreCategories.create(cname: '')
      expect(c).to be_invalid
    end
  end

  context 'When creating a duplicate category' do
    it 'is invalid with duplicate cname' do
      CoreCategories.create(cname: 'Communication')
      c1 = CoreCategories.new(cname: 'Communication')
      expect(c1).to be_invalid
    end
  end
end
