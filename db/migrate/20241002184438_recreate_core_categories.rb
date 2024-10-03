# frozen_string_literal: true

class RecreateCoreCategories < ActiveRecord::Migration[7.2]
  def up
    drop_table :core_categories if ActiveRecord::Base.connection.table_exists?('core_categories')

    create_table :core_categories do |t|
      t.string :cname, limit: 255, null: false

      t.timestamps
    end
  end

  def down
    drop_table :core_categories if ActiveRecord::Base.connection.table_exists?('core_categories')
    create_table :core_categories, id: false do |t|
      t.integer :course_id, null: false
      t.string :cname, limit: 255, null: false

      t.timestamps
    end

    add_index :core_categories, %i[course_id cname], unique: true
    add_foreign_key :core_categories, :courses, column: :course_id
  end
end
