# frozen_string_literal: true

class RecreatePrerequisites < ActiveRecord::Migration[7.2]
  def up
    drop_table :prerequisites if ActiveRecord::Base.connection.table_exists?('prerequisites')

    create_table :prerequisites, id: false, primary_key: %i[course_id prereq_id equi_id] do |t|
      t.references :course, null: false, foreign_key: { to_table: :courses }
      t.references :prereq, null: false, foreign_key: { to_table: :courses }
      t.integer :equi_id, null: false

      t.timestamps
    end

    add_index :prerequisites, %i[course_id prereq_id equi_id], unique: true
  end

  def down
    drop_table :prerequisites if ActiveRecord::Base.connection.table_exists?('prerequisites')

    create_table :prerequisites, id: false, primary_key: :course_id do |t|
      t.integer :course_id
      t.integer :prereq_id

      t.timestamps
    end

    add_index :prerequisites, :course_id
    add_index :prerequisites, :prereq_id
    add_index :prerequisites, %i[course_id prereq_id], unique: true
  end
end
