# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[7.2]
  def change
    create_table :courses, id: false, primary_key: :crn do |t|
      t.integer :crn, null: false, primary_key: true
      t.string :cname, limit: 255
      t.text :description
      t.integer :credit_hours, default: 0
      t.integer :lecture_hours, default: 0
      t.integer :lab_hours, default: 0

      t.timestamps
    end
  end
end
