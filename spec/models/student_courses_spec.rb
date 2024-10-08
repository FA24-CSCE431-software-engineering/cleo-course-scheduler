# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StudentCourse, type: :student_courses do
  before(:each) do
    @default_course = Course.create(ccode: 'CSCE', cnumber: 411, cname: 'Software Engineering', credit_hours: 3)
    @default_major = Major.create(mname: 'Computer Science', cname: 'School of Engineering')
    @default_student = Student.create(
      uin: 123_456_789,
      first_name: 'John',
      last_name: 'Adams',
      email: 'JAdams@gmail.com',
      enrol_year: 2020,
      grad_year: 2024,
      enrol_semester: 0,
      grad_semester: 1,
      major_id: @default_major.id
    )
  end

  context 'When creating a valid student course' do
    it 'is valid with valid attributes' do
      sc = StudentCourse.create(student_id: @default_student.uin, course_id: @default_course.id)
      expect(sc).to be_valid
    end
  end

  context 'When creating an invalid student course' do
    it 'is invalid with invalid attributes' do
      sc = StudentCourse.create(student_id: @default_student.uin, course_id: nil)
      expect(sc).to be_invalid
    end
  end

  context 'When creating a duplicate student course' do
    it 'is invalid with duplicate course_id, student_id' do
      StudentCourse.create(student_id: @default_student.uin, course_id: @default_course.id)
      sc2 = StudentCourse.new(student_id: @default_student.uin, course_id: @default_course.id)
      expect(sc2).to be_invalid
    end
  end

  context 'When creating a two student course' do
    it 'is valid with unique course_id, student_id' do
      course = Course.create(ccode: 'CSCE', cnumber: 435, cname: 'Parallel Computing', credit_hours: 3)
      StudentCourse.create(student_id: @default_student.uin, course_id: @default_course.id)
      sc2 = StudentCourse.create(student_id: @default_student.uin, course_id: course.id)
      expect(sc2).to be_valid
    end
  end
end
