# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'students/profile', type: :view do
  let(:major) { double('Major', mname: 'Computer Science') }
  let(:emphasis) { double('Emphasis', ename: 'Artificial Intelligence') }

  let(:student) do
    double('Student',
           first_name: 'John',
           last_name: 'Doe',
           email: 'john.doe@example.com',
           enrol_year: 2022,
           grad_year: 2026,
           enrol_semester: 'fall',
           grad_semester: 'spring',
           major:,
           emphasis:,
           total_credits_completed: 95,
           google_id: '12345')
  end

  before do
    assign(:student, student)
    allow(view).to receive(:edit_student_path).with(student.google_id).and_return('/students/12345/edit')
    stub_template 'shared/_navbar_student.html.erb' => '<nav>Navbar content here</nav>'
    render
  end

  # it "renders the navbar partial" do
  #   expect(rendered).to have_selector("nav", text: "Navbar content here")
  # end
  it 'renders the navbar partial' do
    expect(rendered).to have_selector('nav')
    # expect(rendered).to have_link("Back to Home", href: admin_dashboard_path)
  end

  it "displays the student's name" do
    expect(rendered).to have_selector('p.profile-info', text: 'Name: John Doe')
  end

  it "displays the student's email" do
    expect(rendered).to have_selector('p.profile-info', text: 'Email: john.doe@example.com')
  end

  it "displays the student's enrollment year" do
    expect(rendered).to have_selector('p.profile-info', text: 'Enrollment Year: 2022')
  end

  it "displays the student's graduation year" do
    expect(rendered).to have_selector('p.profile-info', text: 'Graduation Year: 2026')
  end

  it "displays the student's enrollment semester in human-readable format" do
    expect(rendered).to have_selector('p.profile-info', text: 'Enrollment Semester: Fall')
  end

  it "displays the student's graduation semester in human-readable format" do
    expect(rendered).to have_selector('p.profile-info', text: 'Graduation Semester: Spring')
  end

  it "displays the student's major if present" do
    expect(rendered).to have_selector('p.profile-info', text: 'Major: Computer Science')
  end

  it "displays the student's emphasis if present" do
    expect(rendered).to have_selector('p.profile-info', text: 'Emphasis: Artificial Intelligence')
  end

  it 'displays the credits scale with the correct fill percentage' do
    expected_fill_width = (student.total_credits_completed / 126.0 * 100).round(2)
    expect(rendered).to have_css(".credits-scale-fill[style='width: #{expected_fill_width}%']")
  end

  it 'displays the year markers for the credits scale' do
    ['Year 0', 'Year 1', 'Year 2', 'Year 3', 'Year 4'].each do |year|
      expect(rendered).to have_selector('div.credits-scale-markers span', text: year)
    end
  end

  it "has a link to edit the student's profile" do
    expect(rendered).to have_link('Edit Profile', href: '/students/12345/edit')
  end
end
