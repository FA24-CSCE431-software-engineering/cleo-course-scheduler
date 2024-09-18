# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[7.2]
  def change
    create_table :courses do |t|
      t.string :ccode, limit: 4
      t.integer :cnumber
      t.string :cname, limit: 255
      t.text :description
      t.integer :credit_hours, default: 0
      t.integer :lecture_hours, default: 0
      t.integer :lab_hours, default: 0

      t.timestamps
    end

    add_index :courses, %i[ccode cnumber], unique: true
  end
end
