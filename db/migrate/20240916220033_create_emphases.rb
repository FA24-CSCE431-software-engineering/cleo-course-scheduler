# frozen_string_literal: true

class CreateEmphases < ActiveRecord::Migration[7.2]
  def change
    create_table :emphases do |t|
      t.integer :crn, null: false
      t.string :ename, limit: 255, null: false

      t.timestamps
    end
    add_index :emphases, %i[crn ename], unique: true
    add_foreign_key :emphases, :courses, column: :crn, primary_key: :crn
  end
end
