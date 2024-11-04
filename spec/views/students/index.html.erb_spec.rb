# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'students/index', type: :view do
  let(:major1) { double('Major', id: 1, mname: 'Computer Science') }
  let(:major2) { double('Major', id: 2, mname: 'Electrical Engineering') }

  let(:students) do
    [
      double('Student',
             id: '123456789',
             first_name: 'John',
             last_name: 'Doe',
             email: 'john.doe@example.com',
             enrol_year: 2022,
             grad_year: 2026,
             enrol_semester: 'Fall',
             grad_semester: 'Spring',
             major: major1),
      double('Student',
             id: '987654321',
             first_name: 'Jane',
             last_name: 'Smith',
             email: 'jane.smith@example.com',
             enrol_year: 2023,
             grad_year: 2027,
             enrol_semester: 'Spring',
             grad_semester: 'Fall',
             major: major2),
      double('Student',
             id: '456789123',
             first_name: 'Bob',
             last_name: 'Johnson',
             email: 'bob.johnson@example.com',
             enrol_year: 2023,
             grad_year: 2027,
             enrol_semester: 'Fall',
             grad_semester: 'Spring',
             major: nil)
    ]
  end

  before do
    assign(:students, students)
    # Stub the path helpers
    allow(view).to receive(:admin_dashboard_path).and_return('/admin/dashboard')
    allow(view).to receive(:edit_student_path).and_return('/students/1/edit')
    allow(view).to receive(:confirm_destroy_student_path).and_return('/students/1/confirm_destroy')
    # Stub the navbar partial
    stub_template 'shared/_navbar_student.html.erb' => '<nav><%= link_to "Back to Home", admin_dashboard_path %></nav>'
    render
  end

  it 'renders the navbar partial' do
    expect(rendered).to have_selector('nav')
    expect(rendered).to have_link('Back to Home', href: admin_dashboard_path)
  end

  it 'displays the page title' do
    expect(rendered).to have_selector('h1', text: 'Students')
  end

  it 'displays the table headers' do
    expect(rendered).to have_selector('th', text: 'UIN')
    expect(rendered).to have_selector('th', text: 'First Name')
    expect(rendered).to have_selector('th', text: 'Last Name')
    expect(rendered).to have_selector('th', text: 'Email')
    expect(rendered).to have_selector('th', text: 'Enrollment Year')
    expect(rendered).to have_selector('th', text: 'Graduation Year')
    expect(rendered).to have_selector('th', text: 'Enrollment Semester')
    expect(rendered).to have_selector('th', text: 'Graduation Semester')
    expect(rendered).to have_selector('th', text: 'Major')
    expect(rendered).to have_selector('th', text: 'Actions')
  end

  context 'when displaying student information' do
    it 'shows correct information for students with majors' do
      expect(rendered).to include('123456789')
      expect(rendered).to include('John')
      expect(rendered).to include('Doe')
      expect(rendered).to include('john.doe@example.com')
      expect(rendered).to include('2022')
      expect(rendered).to include('2026')
      expect(rendered).to include('Fall')
      expect(rendered).to include('Spring')
      expect(rendered).to include('Computer Science')
    end

    it "displays 'N/A' for students without a major" do
      expect(rendered).to include('456789123')
      expect(rendered).to include('Bob')
      expect(rendered).to include('Johnson')
      expect(rendered).to include('N/A')
    end
  end

  context 'when displaying action links' do
    it 'shows edit and delete links for each student' do
      students.each do |_student|
        expect(rendered).to have_link('Edit', href: '/students/1/edit')
        expect(rendered).to have_link('Delete', href: '/students/1/confirm_destroy')
      end
    end
  end
end
