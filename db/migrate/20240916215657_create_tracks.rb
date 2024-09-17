# frozen_string_literal: true

class CreateTracks < ActiveRecord::Migration[7.2]
  def change
    create_table :tracks, id: false do |t|
      t.integer :crn, null: false
      t.string :tname, limit: 255, null: false

      t.timestamps
    end
    add_index :tracks, %i[crn tname], unique: true
    add_foreign_key :tracks, :courses, column: :crn, primary_key: :crn
  end
end
