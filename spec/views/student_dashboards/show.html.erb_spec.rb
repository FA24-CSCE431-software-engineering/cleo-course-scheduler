# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'student_dashboards/show.html.erb', type: :view do
  let(:student) { double('Student', full_name: 'John Doe', avatar_url: nil, google_id: '12345') }

  before do
    allow(view).to receive(:current_student_login).and_return(student)
    assign(:student, student)
    allow(view).to receive(:student_dashboard_path).and_return("/student_dashboard/#{student.google_id}")
    allow(view).to receive(:profile_student_path).with(student).and_return("/profile/student/#{student.google_id}")
    allow(view).to receive(:student_degree_planner_path).with(student.google_id).and_return("/student/degree_planner/#{student.google_id}")
    allow(view).to receive(:support_index_path).and_return('/support')
    allow(view).to receive(:destroy_student_login_session_path).and_return('/logout')
    render
  end

  it 'includes the student avatar in the header' do
    expect(rendered).to have_selector('.profile-avatar')
  end

  it "displays the student's full name in the welcome message" do
    expect(rendered).to include('Welcome, John Doe!')
  end

  it 'includes the sidebar links' do
    expect(rendered).to have_link('Home', href: "/student_dashboard/#{student.google_id}")
    expect(rendered).to have_link('Profile', href: "/profile/student/#{student.google_id}")
    expect(rendered).to have_link('Degree Planner', href: "/student/degree_planner/#{student.google_id}")
    expect(rendered).to have_link('Support', href: '/support')
    expect(rendered).to have_link('Sign Out', href: '/logout')
  end

  it 'includes the dashboard main image' do
    expect(rendered).to have_selector(".dashboard-image[alt='Dashboard']")
  end

  it 'displays the degree planning section title' do
    expect(rendered).to have_selector('h1.planning-title', text: 'Start Planning Your Degree')
  end
end
