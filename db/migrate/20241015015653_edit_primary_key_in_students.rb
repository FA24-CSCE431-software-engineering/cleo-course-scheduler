# frozen_string_literal: true

class EditPrimaryKeyInStudents < ActiveRecord::Migration[7.2]
  def up
    # Drop the student_courses table if it exists
    drop_table :student_courses if table_exists?(:student_courses)

    drop_table :students if table_exists?(:students) # Ensure we drop the existing table if it exists

    create_table :students, id: false, force: :cascade do |t|
      t.string 'google_id', null: false, primary_key: true # Set google_id as the primary key
      t.string 'first_name', limit: 255
      t.string 'last_name', limit: 255
      t.string 'email', limit: 255
      t.integer 'enrol_year'
      t.integer 'enrol_semester'
      t.integer 'grad_year'
      t.integer 'grad_semester'
      t.bigint 'major_id', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.boolean 'is_admin', default: false, null: false
      t.bigint 'track_id'
      t.bigint 'emphases_id'

      # Add indexes for performance
      t.index ['emphases_id'], name: 'index_students_on_emphases_id'
      t.index ['major_id'], name: 'index_students_on_major_id'
      t.index ['track_id'], name: 'index_students_on_track_id'
    end

    # Create student_courses table
    create_table :student_courses, id: false, force: :cascade do |t|
      t.string 'student_id', null: false # Ensure this is a string
      t.bigint 'course_id', null: false
      t.integer 'sem', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false

      # Indexes for efficient querying
      t.index ['course_id'], name: 'index_student_courses_on_course_id'
      t.index %w[student_id course_id], name: 'index_student_courses_on_student_id_and_course_id', unique: true
      t.index ['student_id'], name: 'index_student_courses_on_student_id'
    end

    # Add foreign key constraint to student_courses
    add_foreign_key :student_courses, :students, column: :student_id, primary_key: :google_id
  end

  def down
    # Rollback logic
    drop_table :student_courses if table_exists?(:student_courses)
    drop_table :students if table_exists?(:students)
  end
end
