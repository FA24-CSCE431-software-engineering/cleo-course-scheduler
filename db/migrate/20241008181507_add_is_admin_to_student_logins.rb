# frozen_string_literal: true

class AddIsAdminToStudentLogins < ActiveRecord::Migration[7.2]
  def change
    add_column :student_logins, :is_admin, :boolean, default: false, null: false
  end
end
