# frozen_string_literal: true

class AddIndexToCourses < ActiveRecord::Migration[7.2]
  def change
    add_index :courses, %i[ccode cnumber], unique: true
  end
end
