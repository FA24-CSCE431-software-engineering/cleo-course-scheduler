class CreateDegreeRequirements < ActiveRecord::Migration[7.2]
  def change
    create_table :degree_requirements, id: false do |t|
      t.belongs_to :major, null: false, foreign_key: true
      t.belongs_to :course, null: false, foreign_key: { to_table: :courses, primary_key: :crn }

      t.timestamps
    end
  
    add_index :degree_requirements, [:major_id, :course_id], unique: true
  end
end
