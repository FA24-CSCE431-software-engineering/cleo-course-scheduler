# frozen_string_literal: true

class CreateCoursesMajors < ActiveRecord::Migration[6.0]
  def change
    create_table :courses_majors do |t|
      t.references :course, null: false, foreign_key: true
      t.references :major, null: false, foreign_key: true

      t.timestamps
    end
  end
end
