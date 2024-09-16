class CreatePrerequisites < ActiveRecord::Migration[7.2]
  def change
    create_table :prerequisites, id: false, primary_key: :course_crn do |t|
      t.integer :course_crn
      t.integer :prereq_crn

      t.timestamps
    end

    add_index :prerequisites, :course_crn
    add_index :prerequisites, :prereq_crn

    add_index :prerequisites, [:course_crn, :prereq_crn], unique: true
  end
end
