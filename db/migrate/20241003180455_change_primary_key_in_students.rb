# frozen_string_literal: true

class ChangePrimaryKeyInStudents < ActiveRecord::Migration[7.2]
  def up
    drop_table :student_courses
    remove_column :students, :uin

    add_column :students, :google_id, :integer, null: false, primary_key: true
    add_column :students, :is_admin, :boolean, default: false, null: false

    create_table :student_courses, id: false, primary_key: %i[student_id course_id] do |t|
      t.belongs_to :student, null: false, foreign_key: { to_table: :students, primary_key: :google_id }
      t.belongs_to :course, null: false, foreign_key: true
      t.integer :sem, null: false

      t.timestamps
    end

    add_index :student_courses, %i[student_id course_id], unique: true
  end

  def down
    drop_table :student_courses

    remove_column :students, :google_id
    add_column :students, :uin, :integer, null: false, primary_key: true

    create_table :student_courses, id: false do |t|
      t.belongs_to :student, null: false, foreign_key: { to_table: :students, primary_key: :uin }
      t.belongs_to :course, null: false, foreign_key: true
      t.integer :sem, null: false

      t.timestamps
    end

    add_index :student_courses, %i[student_id course_id], unique: true
  end
end
