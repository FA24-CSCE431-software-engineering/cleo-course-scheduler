RSpec.shared_context 'logged in student', :shared_context => :metadata do
  include UserLoginHelper

  before(:each) do
    mock_current_student_login
  end 
end

RSpec.shared_context 'logged in admin', :shared_context => :metadata do
  include UserLoginHelper

  before(:each) do
    mock_current_student_login_admin
  end
end