class AddIdToStudentCourses < ActiveRecord::Migration[7.2]
  def change
    add_column :student_courses, :id, :primary_key
  end
end
