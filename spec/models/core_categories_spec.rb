# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoreCategories, type: :core_categories do
  before(:each) do
    @default_course = Course.create(crn: 1, cname: 'Software Engineering', credit_hours: 3)
  end

  context 'When creating a valid category' do
    it 'is valid with valid attributes' do
      category = CoreCategories.create(crn: 1, cname: 'Communication')
      expect(category).to be_valid
    end
  end

  context 'When creating an invalid category' do
    it 'is invalid with invalid attributes' do
      category = CoreCategories.create(crn: 1, cname: '')
      expect(category).to be_invalid
    end
  end

  context 'When creating a duplicate category' do
    it 'is invalid with duplicate crn, cname' do
      CoreCategories.create(crn: 1, cname: 'Communication')
      c2 = CoreCategories.new(crn: 1, cname: 'Communication')
      expect(c2).to be_invalid
    end
  end

  context 'When creating two category' do
    it 'is valid with unique crn, cname' do
      CoreCategories.create(crn: 1, cname: 'Communication')
      c2 = CoreCategories.create(crn: 1, cname: 'Mathematics')
      expect(c2).to be_valid
    end
  end
end
