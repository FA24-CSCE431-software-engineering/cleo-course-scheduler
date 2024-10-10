# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student, type: :model do
  before(:each) do
    @default_major = Major.create(mname: 'Computer Science', cname: 'School of Engineering')
    @default_student = Student.create(google_id: 123_456_789,
                                      first_name: 'John',
                                      last_name: 'Adams',
                                      email: 'JAdams@gmail.com',
                                      enrol_year: 2020,
                                      grad_year: 2024,
                                      enrol_semester: 0,
                                      grad_semester: 1,
                                      major: @default_major)
  end

  context 'When creating a valid student' do
    it 'is valid with valid attributes' do
      expect(@default_student).to be_valid
    end
  end

  context 'When creating an invalid student' do
    it 'is not valid with duplicate uin' do
      student = Student.create(google_id: 123_456_789,
                               first_name: 'Jack',
                               last_name: 'Adams',
                               email: 'JAdams@gmail.com',
                               enrol_year: 2020,
                               grad_year: 2024,
                               enrol_semester: 0,
                               grad_semester: 1)
      expect(student).to be_invalid
    end
  end
end
