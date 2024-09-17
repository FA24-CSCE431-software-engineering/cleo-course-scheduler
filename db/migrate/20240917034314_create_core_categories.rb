class CreateCoreCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :core_categories, id: false do |t|
      t.integer :crn, null: false
      t.string :cname, limit: 255, null: false

      t.timestamps
    end
    add_index :core_categories, [:crn, :cname], unique: true
    add_foreign_key :core_categories, :courses, column: :crn, primary_key: :crn
  end
end
