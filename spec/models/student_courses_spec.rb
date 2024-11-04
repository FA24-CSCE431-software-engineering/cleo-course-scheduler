# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StudentCourse, type: :student_courses do
  include_context 'models setup'

  context 'When creating a valid student course' do
    it 'is valid with valid attributes' do
      expect(student_course).to be_valid
    end
  end

  context 'When creating an invalid student course' do
    it 'is invalid with missing attributes' do
      invalid_student_course = StudentCourse.create(student:)
      expect(invalid_student_course).to be_invalid
    end
  end

  context 'When creating a duplicate student course' do
    it 'is invalid with duplicate course_id, student_id' do
      dup_student_course = StudentCourse.new(
        student: student_course.student,
        course: student_course.course,
        sem: student_course.sem
      )
      expect(dup_student_course).to be_invalid
    end
  end

  context 'When creating two student course' do
    it 'is valid with unique course_id, student_id' do
      course = Course.create(ccode: 'CSCE', cnumber: 435, cname: 'Parallel Computing', credit_hours: 3)
      unique_student_course = StudentCourse.create(student: student_course.student, course:, sem: 1)
      expect(unique_student_course).to be_valid
    end
  end
end
