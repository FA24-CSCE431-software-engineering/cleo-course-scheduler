class ChangeStudentIdToStringInStudentCourses < ActiveRecord::Migration[7.2]
  def change
    change_column :student_courses, :student_id, :string
  end
end
