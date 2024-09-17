class CreateStudentCourses < ActiveRecord::Migration[7.2]
  def change
    create_table :student_courses, id: false do |t|
      t.belongs_to :student, null: false, foreign_key: { to_table: :students, primary_key: :uin }
      t.belongs_to :course, null: false, foreign_key: { to_table: :courses, primary_key: :crn }

      t.timestamps
    end

    add_index :student_courses, [:student_id, :course_id], unique: true
  end
end
