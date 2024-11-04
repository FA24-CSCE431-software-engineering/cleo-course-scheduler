# frozen_string_literal: true

# spec/views/home/index.html.erb_spec.rb
require 'rails_helper'

RSpec.describe 'home/index', type: :view do
  before do
    # Assign any flash messages you want to test
    # flash[:notice] = "Welcome back, user!"  # Example flash message
    render
  end

  # it "displays the Cleo logo" do
  #   render
  #   expect(rendered).to have_selector("img.cleo-logo[src='/assets/logo1.png']")
  # end

  # it "displays the flash notice if present" do
  #   flash[:notice] = "Welcome back, user!" # Set a flash message
  #   render
  #   expect(rendered).to have_selector("div.alert.alert-success.flash-notice", text: "Welcome back, user!")
  # end

  it 'does not display the flash notice if not present' do
    flash[:notice] = nil
    render
    expect(rendered).not_to have_selector('div.alert.alert-success.flash-notice')
  end

  it 'displays the logout message' do
    expect(rendered).to have_selector('h2.logout-message', text: "You're Logged out! Log in to the Dashboard!")
  end

  it 'displays the get started message' do
    expect(rendered).to have_selector('h3', text: 'Get Started with your Degree Planner')
  end

  it 'displays the Google login button' do
    expect(rendered).to have_selector('button.btn.btn-danger.google-btn', text: 'Login with Google')
    expect(rendered).to have_selector('button.btn.btn-danger.google-btn i.fab.fa-google')
  end

  it 'the Google login button submits to the correct path' do
    expect(rendered).to have_selector("form[action='#{student_login_google_oauth2_omniauth_authorize_path}'][method='post']") do
      expect(rendered).to have_selector('button.btn.btn-danger.google-btn', text: 'Login with Google')
    end
  end
end
