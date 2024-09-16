class CreateStudents < ActiveRecord::Migration[7.2]
  def change
    create_table :students, id: false, primary_key: :uin do |t|
      t.integer :uin, null: false, primary_key: true
      t.string :first_name, limit: 255
      t.string :last_name, limit: 255
      t.string :email, limit: 255
      t.integer :enrol_year
      t.integer :enrol_semester
      t.integer :grad_year
      t.integer :grad_semester
      t.integer :major_id
      t.integer :degree_plan_id

      t.timestamps
    end
  end
end
