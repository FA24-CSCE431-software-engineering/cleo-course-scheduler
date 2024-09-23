class AddCnumberToCourses < ActiveRecord::Migration[7.2]
  def change
    add_column :courses, :cnumber, :integer
  end
end
