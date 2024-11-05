# frozen_string_literal: true

# spec/controllers/application_controller_spec.rb

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#current_student' do
    controller do
      def current_student_login
        # Simulate a method that returns a student login
        StudentLogin.new(uid: '123456', email: 'test@example.com')
      end
    end

    it 'returns the current student login' do
      # Call the current_student method directly
      student = controller.send(:current_student)

      expect(student.uid).to eq('123456')
      expect(student.email).to eq('test@example.com')
    end
  end
end
