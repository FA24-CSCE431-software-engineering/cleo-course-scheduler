class AddSemToStudentCourses < ActiveRecord::Migration[7.2]
  def change
    add_column :student_courses, :sem, :integer
  end
end
