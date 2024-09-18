# frozen_string_literal: true

class CreateDegreeRequirements < ActiveRecord::Migration[7.2]
  def change
    create_table :degree_requirements, id: false do |t|
      t.belongs_to :major, null: false, foreign_key: true
      t.belongs_to :course, null: false, foreign_key: true

      t.timestamps
    end

    add_index :degree_requirements, %i[major_id course_id], unique: true
  end
end
