class AddUinToStudentCourses < ActiveRecord::Migration[7.2]
  def change
    add_column :student_courses, :uin, :integer
  end
end
