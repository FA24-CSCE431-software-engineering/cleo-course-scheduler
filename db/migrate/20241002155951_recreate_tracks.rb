# frozen_string_literal: true

class RecreateTracks < ActiveRecord::Migration[7.2]
  def up
    drop_table :tracks if ActiveRecord::Base.connection.table_exists?('tracks')

    create_table :tracks do |t|
      t.string :tname, limit: 255, null: false

      t.timestamps
    end
  end

  def down
    drop_table :tracks if ActiveRecord::Base.connection.table_exists?('tracks')
    create_table :tracks, id: false do |t|
      t.integer :course_id, null: false
      t.string :tname, limit: 255, null: false

      t.timestamps
    end

    add_index :tracks, %i[course_id tname], unique: true
    add_foreign_key :tracks, :courses, column: :course_id
  end
end
