# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StudentCourses', type: :request do
  let(:major) { Major.find_or_create_by(mname: 'Computer Science', cname: 'College of Engineering') }

  let(:student) do
    Student.create!(
      first_name: 'John',
      last_name: 'Doe',
      google_id: 123_456_789,
      email: 'JohnDoe@email.com',
      enrol_year: 2020,
      grad_year: 2024,
      enrol_semester: 1,
      grad_semester: 1,
      major:
    )
  end

  let(:course) do
    Course.create!(
      ccode: 'CSCE',
      cnumber: 431,
      cname: 'Software Engineering',
      description: 'Application of engineering approach to computer software design and development; life cycle models, software requirements and specification; conceptual model design; detailed design; validation and verification; design quality assurance; software design/development environments and project management.',
      credit_hours: 3,
      lecture_hours: 2,
      lab_hours: 2
    )
  end

  let(:valid_attributes) do
    {
      student_id: student.id,
      course_id: course.id,
      sem: 1
    }
  end

  let(:student_course) { StudentCourse.create!(valid_attributes) } # DRY: creates student_course for reuse

  describe 'GET /index' do
    it 'returns http success' do
      get student_courses_path(student_id: student.id, course_id: course.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get student_course_path(student_course, student_id: student.id, course_id: course.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_student_course_path(student_id: student.id, course_id: course.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'creates a new StudentCourse and returns a redirect' do
      post student_courses_path, params: { student_course: valid_attributes }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      StudentCourse.create!(student_id: student.id, course_id: course.id, sem: 3)
      get edit_student_course_path(student_id: student.id, course_id: course.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'updates the StudentCourse and redirects' do
      StudentCourse.create!(student_id: student.id, course_id: course.id, sem: 1)
      patch student_course_path(student_id: student.id, course_id: course.id),
            params: { student_course: { course_id: course.id + 1 } }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes the StudentCourse and redirects' do
      StudentCourse.create!(student_id: student.id, course_id: course.id, sem: 1)
      delete student_course_path(student_id: student.id, course_id: course.id)
      expect(response).to have_http_status(:redirect)
    end
  end
end
