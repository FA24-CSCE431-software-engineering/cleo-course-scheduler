# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'students/confirm_destroy.html.erb', type: :view do
  let(:student) { Student.new(first_name: 'John', last_name: 'Doe', google_id: '1234') }

  before do
    assign(:student, student)
    render
  end

  it 'displays a confirmation message' do
    expect(rendered).to have_selector('h1', text: 'Are you sure you want to delete this student?')
  end

  it 'displays the student\'s first and last name' do
    expect(rendered).to have_content('First Name:')
    expect(rendered).to have_content('John')
    expect(rendered).to have_content('Last Name:')
    expect(rendered).to have_content('Doe')
  end

  it 'renders a form to delete the student' do
    expect(rendered).to have_selector("form[action='#{student_path(student.google_id)}'][method='post']")
    expect(rendered).to have_selector("input[name='_method'][value='delete']", visible: false)
  end

  it 'has a delete button with appropriate styling' do
    expect(rendered).to have_button('Delete Student', class: 'btn btn-danger')
  end

  it 'has a cancel link back to the students index' do
    expect(rendered).to have_link('Cancel', href: students_path, class: 'btn btn-secondary')
  end
end
