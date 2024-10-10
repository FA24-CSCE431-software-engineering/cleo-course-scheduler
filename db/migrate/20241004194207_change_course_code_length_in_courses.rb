# frozen_string_literal: true

class ChangeCourseCodeLengthInCourses < ActiveRecord::Migration[7.2]
  def change
    remove_column :courses, :ccode
    add_column :courses, :ccode, :string, limit: 30
  end
end
