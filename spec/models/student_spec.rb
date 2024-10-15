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

  context 'When creating a student with a valid emphasis' do
    it 'is valid' do
      # Ensure that both Major and Emphasis records are created
      @default_major = Major.create!(mname: 'uhh', cname: 'School of Engineering')
      @default_emphasis = Emphasis.create!(ename: 'Mathematics')
  
      # Create the student and pass the correct IDs for major_id and emphasis_id
      student = Student.create(
        google_id: 133_456_789,
        first_name: 'Jack',
        last_name: 'Adams',
        email: 'JA4ams@gmail.com',
        enrol_year: 2020,
        grad_year: 2024,
        enrol_semester: 0,
        grad_semester: 1,
        major_id: @default_major.id, # Assign the correct major_id
        emphasis_id: @default_emphasis.id # Assign the correct emphasis_id
      )
      
      # Ensure the student is valid
      expect(student).to be_valid
    end
  end

  context 'When creating a student with a invalid emphasis' do
    it 'is not valid' do
      # Ensure that both Major and Emphasis records are created
      @default_major = Major.create!(mname: 'uhh', cname: 'School of Engineering')
      @default_emphasis = Emphasis.create!(ename: 'Mathematics')
  
      # Create the student and pass the correct IDs for major_id and emphasis_id
      student = Student.create(
        google_id: 133_456_789,
        first_name: 'Jack',
        last_name: 'Adams',
        email: 'JA4ams@gmail.com',
        enrol_year: 2020,
        grad_year: 2024,
        enrol_semester: 0,
        grad_semester: 1,
        major_id: nil, # Assign the correct major_id
        emphasis_id: @default_emphasis.id # Assign the correct emphasis_id
      )
      
      # Ensure the student is valid
      expect(student).to be_invalid
    end
  end

  context 'When creating a student with a valid track' do
    it 'is valid' do
      # Ensure that both Major and Emphasis records are created
      @default_major = Major.create!(mname: 'uhh', cname: 'School of Engineering')
      @default_emphasis = Emphasis.create!(ename: 'Mathematics')
  
      # Create the student and pass the correct IDs for major_id and emphasis_id
      student = Student.create(
        google_id: 133_456_789,
        first_name: 'Jack',
        last_name: 'Adams',
        email: 'JA4ams@gmail.com',
        enrol_year: 2020,
        grad_year: 2024,
        enrol_semester: 0,
        grad_semester: 1,
        major_id: @default_major.id, # Assign the correct major_id
        emphasis_id: @default_emphasis.id # Assign the correct emphasis_id
        track_id: 'Systems'
      )
      
      # Ensure the student is valid
      expect(student).to be_valid
    end
  end

  context 'When creating a student with a valid emphasis' do
    it 'is valid' do
      # Ensure that both Major and Emphasis records are created
      @default_major = Major.create!(mname: 'uhh', cname: 'School of Engineering')
      @default_emphasis = Emphasis.create!(ename: 'Mathematics')
  
      # Create the student and pass the correct IDs for major_id and emphasis_id
      student = Student.create(
        google_id: 133_456_789,
        first_name: 'Jack',
        last_name: 'Adams',
        email: 'JA4ams@gmail.com',
        enrol_year: 2020,
        grad_year: 2024,
        enrol_semester: 0,
        grad_semester: 1,
        major_id: @default_major.id, # Assign the correct major_id
        emphasis_id: @default_emphasis.id # Assign the correct emphasis_id
        track_id: nil
      )
      
      # Ensure the student is valid
      expect(student).to be_invalid
    end
  end
end
