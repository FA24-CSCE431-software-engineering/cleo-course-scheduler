# frozen_string_literal: true

class CreateCourseEmphasis < ActiveRecord::Migration[7.2]
  def change
    create_table :course_emphases, id: false, primary_key: %i[course_id emphasis_id] do |t|
      t.references :course, null: false, foreign_key: true
      t.references :emphasis, null: false, foreign_key: true
      t.integer :year, null: false

      t.timestamps
    end

    add_index :course_emphases, %i[course_id emphasis_id year], unique: true
  end
end
