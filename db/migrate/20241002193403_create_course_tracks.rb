# frozen_string_literal: true

class CreateCourseTracks < ActiveRecord::Migration[7.2]
  def change
    create_table :course_tracks, id: false, primary_key: %i[course_id track_id] do |t|
      t.references :course, null: false, foreign_key: true
      t.references :track, null: false, foreign_key: true
      t.integer :year

      t.timestamps
    end

    add_index :course_tracks, %i[course_id track_id year], unique: true
  end
end
