# frozen_string_literal: true

class DeviseCreateStudentLogins < ActiveRecord::Migration[7.2]
  def change
    create_table :student_logins do |t|
      t.string :email, null: false
      t.string :full_name
      t.string :uid
      t.string :avatar_url
      t.timestamps null: false
    end

    add_index :student_logins, :email, unique: true
  end
end
