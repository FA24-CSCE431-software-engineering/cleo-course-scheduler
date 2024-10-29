# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student, type: :model do
  include_context 'models setup'

  context 'When creating a valid student' do
    it 'is valid with valid attributes' do
      expect(student).to be_valid
    end
  end

  context 'When creating an invalid student' do
    it 'is not valid with duplicate uin' do
      invalid_student = Student.create(
        google_id: student.google_id,
        first_name: 'Jack',
        last_name: 'Adams',
        email: 'JAdams@gmail.com',
        major: student.major,
        enrol_year: 2020,
        grad_year: 2024,
        enrol_semester: 0,
        grad_semester: 1
      )
      expect(invalid_student).to be_invalid
    end
  end

  context 'When creating an invalid student' do
    it 'is not valid with missing email' do
      invalid_student = Student.create(
        google_id: 1,
        first_name: 'Jack',
        last_name: 'Adams',
        major: student.major,
        enrol_year: 2020,
        grad_year: 2024,
        enrol_semester: 0,
        grad_semester: 1
      )
      expect(invalid_student).to be_invalid
    end
  end

  context 'When creating an invalid student' do
    it 'is not valid with non alphanumeric characters in name' do
      invalid_student = Student.create(
        google_id: 1,
        first_name: 'Jack!',
        last_name: 'Adams',
        major: student.major,
        enrol_year: 2020,
        grad_year: 2024,
        enrol_semester: 0,
        grad_semester: 1
      )
      expect(invalid_student).to be_invalid
    end
  end

  context 'When creating an invalid student' do
    it 'is not valid with enrol_year greater than grad_year' do
      invalid_student = Student.create(
        google_id: 1,
        first_name: 'Jack',
        last_name: 'Adams',
        major: student.major,
        enrol_year: 2024,
        grad_year: 2020,
        enrol_semester: 0,
        grad_semester: 1
      )
      expect(invalid_student).to be_invalid
    end
  end

  context 'When creating a student with a valid emphasis' do
    it 'is valid' do
      student.update(emphasis_id: emphasis.id)
      expect(student).to be_valid
    end
  end

  context 'When creating a student with a valid track' do
    it 'is valid' do
      student.update(track_id: track.id)
      expect(student).to be_valid
    end
  end
end
