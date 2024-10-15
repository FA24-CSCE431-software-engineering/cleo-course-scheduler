# frozen_string_literal: true

class CreateCoursesStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :courses_students, id: false do |t|
      t.belongs_to :course
      t.belongs_to :student
    end
  end
end
