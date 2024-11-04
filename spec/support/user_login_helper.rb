# frozen_string_literal: true

# spec/helpers/user_login_helper.rb
module UserLoginHelper
  def mock_current_student_login
    student_login = instance_double(
      StudentLogin,
      email: 'JohnDoe@gmail.com',
      full_name: 'John Doe',
      uid: '12345',
      avatar_url: nil,
      is_admin?: false
    )
    allow_any_instance_of(ApplicationController).to receive(:current_student_login).and_return(student_login)

    student = instance_double(Student, google_id: '12345', is_admin: false)
    allow(Student).to receive(:find).and_return(student)
  end

  def mock_current_student_login_admin
    student_login = instance_double(
      StudentLogin,
      email: 'JohnDoe@gmail.com',
      full_name: 'John Doe',
      uid: '12345',
      avatar_url: nil,
      is_admin?: true
    )
    allow_any_instance_of(ApplicationController).to receive(:current_student_login).and_return(student_login)

    student = instance_double(Student, google_id: '12345', is_admin: true)
    allow(Student).to receive(:find).and_return(student)
  end
end
