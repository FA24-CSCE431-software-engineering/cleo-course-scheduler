class AddForeignKeyToStudentCourses < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :student_courses, :students, column: :student_id, primary_key: :google_id
  end
end
