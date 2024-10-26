# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Major, type: :model do
  include_context 'models setup'

  context 'When creating a valid major' do
    it 'is valid with valid attributes' do
      expect(major).to be_valid
    end
  end

  context 'When creating an invalid major' do
    it 'is invalid with invalid attributes' do
      invalid_major = Major.create(mname: major.mname, cname: '')
      expect(invalid_major).to be_invalid
    end
  end

  context 'When creating an invalid major' do
    it 'is invalid with non alphanumeric name' do
      invalid_major = Major.create(mname: '!!', cname: major.cname)
      expect(invalid_major).to be_invalid
    end
  end

  context 'When creating a duplicate major' do
    it 'is invalid with duplicate mname, cname' do
      dup_major = Major.new(mname: major.mname, cname: major.cname)
      expect(dup_major).to be_invalid
    end
  end

  context 'When creating two majors' do
    it 'is valid with unique mname, cname' do
      unique_major = Major.create(mname: 'Electrical Engineering', cname: 'College of Engineering')
      expect(unique_major).to be_valid
    end
  end
end
