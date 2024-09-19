# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Major, type: :model do
  context 'When creating a valid major' do
    it 'is valid with valid attributes' do
      major = Major.create(mname: 'Computer Science', cname: 'College of Engineering')
      expect(major).to be_valid
    end
  end

  context 'When creating an invalid major' do
    it 'is invalid with invalid attributes' do
      major = Major.create(mname: 'Computer Science', cname: '')
      expect(major).to be_invalid
    end
  end

  context 'When creating a duplicate major' do
    it 'is invalid with duplicate mname, cname' do
      Major.create(mname: 'Computer Science', cname: 'College of Engineering')
      m2 = Major.new(mname: 'Computer Science', cname: 'College of Engineering')
      expect(m2).to be_invalid
    end
  end

  context 'When creating two majors' do
    it 'is valid with unique mname, cname' do
      Major.create(mname: 'Computer Science', cname: 'College of Engineering')
      m2 = Major.create(mname: 'Electrical Engineering', cname: 'College of Engineering')
      expect(m2).to be_valid
    end
  end
end
