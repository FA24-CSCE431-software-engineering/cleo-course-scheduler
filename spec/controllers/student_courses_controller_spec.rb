# frozen_string_literal: true

# spec/controllers/student_courses_controller_spec.rb

require 'rails_helper'

RSpec.describe StudentCoursesController, type: :controller do
  describe 'GET #index' do
    context 'when student_id is not present' do
      it 'assigns @student_courses to none' do
        get :index
        expect(assigns(:student_courses)).to eq(StudentCourse.none)
      end
    end
  end

  describe 'POST #create' do
    let(:major) { Major.create!(mname: 'Test Major1', cname: 'Test Major Full Name1') }
    let(:student) do
      Student.create!(first_name: 'Test', last_name: 'Student', email: 'test1@student.com', google_id: '123457',
                      enrol_year: 2023, grad_year: 2025, enrol_semester: 'spring', grad_semester: 'spring', major:)
    end
    let(:course) { Course.create!(cname: 'Test Course1', ccode: 'TESS', cnumber: 102) }

    it 'creates a new StudentCourse and redirects with a success notice' do
      expect do
        post :create, params: { student_course: { student_id: student.id, course_id: course.id, sem: '1' } }
      end.to change(StudentCourse, :count).by(1)

      expect(response).to redirect_to(student_courses_path(student_id: student.id))
      expect(flash[:notice]).to eq('Course added successfully.')
    end

    it 'renders :new with an alert when the StudentCourse is invalid' do
      expect do
        post :create, params: { student_course: { student_id: student.id, course_id: nil, sem: '1' } }
      end.to change(StudentCourse, :count).by(0)

      expect(response).to render_template(:new)
      expect(flash.now[:alert]).to be_present
    end
  end

  describe 'PATCH #update' do
    let(:major) { Major.create!(mname: 'Test Major', cname: 'Test Major Full Name') }
    let(:student) do
      Student.create!(first_name: 'Test', last_name: 'Student', email: 'test@student.com', google_id: '123456',
                      enrol_year: 2023, grad_year: 2025, enrol_semester: 'spring', grad_semester: 'spring', major:)
    end
    let(:course) { Course.create!(cname: 'Test Course', ccode: 'TEST', cnumber: 101) }
    let!(:student_course) { StudentCourse.create!(student:, course:, sem: '1') }

    it 'redirects to student_courses_path with a success notice' do
      patch :update, params: { student_id: student.id, course_id: course.id, student_course: { course_id: course.id } }

      expect(response).to redirect_to(student_courses_path(student_id: student.id))
      expect(flash[:notice]).to eq('Course updated successfully.')
    end
  end
end
