class AddCcodeToCourses < ActiveRecord::Migration[7.2]
  def change
    add_column :courses, :ccode, :string
  end
end
