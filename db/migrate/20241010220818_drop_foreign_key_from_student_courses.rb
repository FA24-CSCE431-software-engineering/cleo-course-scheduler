# frozen_string_literal: true

class DropForeignKeyFromStudentCourses < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :student_courses, :students
  end
end
