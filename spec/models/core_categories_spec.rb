# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoreCategory, type: :core_categories do
  include_context 'models setup'

  context 'When creating a valid category' do
    it 'is valid with valid attributes' do
      expect(core_category).to be_valid
    end
  end

  context 'When creating an invalid category' do
    it 'is invalid with missing cname' do
      invalid_core_category = CoreCategory.create(cname: '')
      expect(invalid_core_category).to be_invalid
    end
  end

  context 'When creating an invalid category' do
    it 'is invalid with non alphanumeric cname' do
      invalid_core_category = CoreCategory.create(cname: '!!')
      expect(invalid_core_category).to be_invalid
    end
  end

  context 'When creating a duplicate category' do
    it 'is invalid with duplicate cname' do
      dup_core_category = CoreCategory.new(cname: core_category.cname)
      expect(dup_core_category).to be_invalid
    end
  end
end
