# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Courses', type: :request do
  let!(:course) { Course.create(cnumber: 431, cname: 'Software Engineering', ccode: 'CSCE', credit_hours: 3) }

  # Students should not be able to view courses
  describe 'GET admin/courses/index' do
    include_context 'logged in student'
    it 'returns http redirect' do
      get admin_courses_path
      expect(response).to have_http_status(:redirect)
    end
  end

  # Admin should be able to view courses
  describe 'GET admin/courses/index' do
    include_context 'logged in admin'
    it 'returns http redirect' do
      get admin_courses_path
      expect(response).to have_http_status(:success)
    end
  end

  # Admins should be able to update a course
  describe 'GET /admin/courses/:id' do
    include_context 'logged in admin'
    it 'returns http success' do
      get edit_admin_course_path(course)
      expect(response).to have_http_status(:success)
    end
  end

  # Admins should be able to create a course
  describe 'POST /admin/course' do
    include_context 'logged in admin'
    context 'with valid parameters' do
      it 'creates a new course and redirects' do
        expect do
          post admin_courses_path,
               params: { course: { cnumber: 411, cname: 'Algorithms', ccode: 'CSCE', credit_hours: 3 } }
        end.to change(Course, :count).by(1)

        expect(response).to redirect_to(admin_courses_path)
      end
    end

    context 'with invalid parameters' do
      it 'course count remains the same' do
        expect do
          post admin_courses_path, params: { course: { cname: 'Algorithms II' } }
        end.to change(Course, :count).by(0)
      end
    end
  end

  # Admins should be able to access the create course page
  describe 'GET /admin/courses/new' do
    include_context 'logged in admin'
    it 'returns http success' do
      get new_admin_course_path
      expect(response).to have_http_status(:success)
    end
  end

  # Admins should be able to update a course
  describe 'PATCH /admin/courses#update' do
    include_context 'logged in admin'
    it 'updates and redirects to the course show page' do
      patch admin_course_path(course),
            params: { course: { cnumber: 400, cname: 'Updated Course Name', ccode: 'CSCE', credit_hours: 3, description: 'a',
                                lab_hours: 0, lecture_hours: 0 } }
  
      course.reload
      expect(course.cname).to eq('Updated Course Name')
      
      # Update the expectation to reflect the redirect to the show page
      expect(response).to redirect_to(admin_course_path(course)) # Redirects to the show page
    end

    # it "rerenders edit template" do
    #   patch admin_course_path(course), params: { course: { cname: "" } }
    #   expect(response).to render_template(:edit)
    # end
  end

  # Admins should be able to delete a course
  # describe "DELETE /admin/courses/:id" do
  #   include_context "logged in admin"
  #   it "deletes the courses and redirects" do
  #     delete admin_course_path(course)
  #     expect(response).to redirect_to(admin_courses_path)
  #     expect(Course.exists?(course.id)).to be_falsey
  #   end
  # end
end
