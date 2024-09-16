class CreateStudentCourses < ActiveRecord::Migration[7.2]
  def change
    create_table :student_courses, id: false do |t|
      t.integer :uin, null: false
      t.integer :crn, null: false
    end
  
    add_foreign_key :student_courses, :students, column: :uin, primary_key: :uin
    add_foreign_key :student_courses, :courses, column: :crn, primary_key: :crn

    add_index :student_courses, [:uin, :crn], unique: true
  end
end
