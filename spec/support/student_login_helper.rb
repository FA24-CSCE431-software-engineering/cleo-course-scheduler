# spec/helpers/student_login_helper.rb
module StudentLoginHelper
    def mock_current_student_login
      student_login = instance_double(
        StudentLogin,
        email: 'JohnDoe@gmail.com',
        full_name: 'John Doe',
        uid: '12345',
        avatar_url: nil
      )
      allow_any_instance_of(ApplicationController).to receive(:current_student_login).and_return(student_login)
  
      student = instance_double(Student, google_id: '12345')
      allow(Student).to receive(:find).and_return(student)
    end
  end
  