require 'rails_helper'

RSpec.describe "StudentCourses", type: :request do
  let(:major) { Major.find_or_create_by(mname: 'Computer Science', cname: 'College of Engineering') }
  let(:student) { Student.create!(
    first_name: "John", 
    last_name: "Doe", 
    uin: 123456789, 
    email:"JohnDoe@email.com", 
    enrol_year: 2020, 
    grad_year: 2024, 
    enrol_semester: 1, 
    grad_semester: 1, 
    major: major
    ) }
  let(:course) { Course.create!(
    ccode: 'CSCE', 
    cnumber: 431, 
    cname: 'Software Engineering',
    description: 'Application of engineering approach to computer software design and development; life cycle models, 
    software requirements and specification; conceptual model design; detailed design; validation and verification;
    design quality assurance; software design/development environments and project management.', 
    credit_hours: 3, 
    lecture_hours: 2, 
    lab_hours: 2) }
  
  let(:valid_attributes) do
    {
      student_id: student.uin,
      course_id: course.crn
    }
  end
  
  describe "GET /index" do
    it "returns http success" do
      get student_courses_path
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET /show" do
    it "returns http success" do
      student_course = StudentCourse.create!(valid_attributes)
      get student_course_path(student_course)
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET /new" do
    it "returns http success" do
      get new_student_course_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a new StudentCourse and returns a redirect" do
      post student_courses_path, params: { student_course: valid_attributes }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      student_course = StudentCourse.create!(valid_attributes)
      get edit_student_course_path(student_course)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    it "updates the StudentCourse and redirects" do
      student_course = StudentCourse.create!(valid_attributes)
      patch student_course_path(student_course), params: { student_course: { course_id: course.crn } }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "DELETE /destroy" do
    it "deletes the StudentCourse and redirects" do
      student_course = StudentCourse.create!(valid_attributes)
      delete student_course_path(student_course)
      expect(response).to have_http_status(:redirect)
    end
  end
end
