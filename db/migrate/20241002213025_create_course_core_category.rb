# frozen_string_literal: true

class CreateCourseCoreCategory < ActiveRecord::Migration[7.2]
  def change
    create_table :course_core_categories, id: false, primary_key: %i[course_id core_category_id] do |t|
      t.references :course, null: false, foreign_key: true
      t.references :core_category, null: false, foreign_key: true
      t.integer :year, null: false

      t.timestamps
    end

    add_index :course_core_categories, %i[course_id core_category_id year], unique: true
  end
end
