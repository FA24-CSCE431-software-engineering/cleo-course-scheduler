# frozen_string_literal: true

class RecreateDegreeRequirements < ActiveRecord::Migration[7.2]
  def up
    drop_table :degree_requirements if ActiveRecord::Base.connection.table_exists?('degree_requirements')

    create_table :degree_requirements, id: false, primary_key: %i[course_id major_id year] do |t|
      t.references :course, null: false, foreign_key: true
      t.references :major, null: false, foreign_key: true
      t.integer :year, null: false
      t.integer :sem, null: false

      t.timestamps
    end

    add_index :degree_requirements, %i[course_id major_id year], unique: true
  end

  def down
    drop_table :degree_requirements if ActiveRecord::Base.connection.table_exists?('degree_requirements')
    create_table :degree_requirements, id: false do |t|
      t.belongs_to :major, null: false, foreign_key: true
      t.belongs_to :course, null: false, foreign_key: true

      t.timestamps
    end

    # Add the old index (major_id, course_id)
    add_index :degree_requirements, %i[major_id course_id], unique: true
  end
end
