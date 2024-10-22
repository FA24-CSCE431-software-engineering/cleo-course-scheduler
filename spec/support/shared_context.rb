RSpec.shared_context 'logged in student', :shared_context => :metadata do
  include StudentLoginHelper

  before(:each) do
    mock_current_student_login
  end 
end