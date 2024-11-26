require 'rails_helper'

RSpec.describe 'admin/prerequisites/_form', type: :view do
  let(:prerequisite) { Prerequisite.new }

  before do
    assign(:prerequisite, prerequisite)
  end

  it 'renders a form with the correct attributes' do
    render partial: 'admin/prerequisites/form', locals: { prerequisite: prerequisite }

    expect(rendered).to have_selector('form[method=post]')
    expect(rendered).to have_selector('input#prerequisite_course_id')
    expect(rendered).to have_selector('input#prerequisite_prereq_id')
    expect(rendered).to have_selector('input#prerequisite_equi_id')
  end
end
