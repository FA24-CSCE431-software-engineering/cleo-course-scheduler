# frozen_string_literal: true

class AddTrackIdToStudents < ActiveRecord::Migration[7.2]
  def up
    add_reference :students, :track, foreign_key: true
  end

  def down
    remove_reference :students, :track, foreign_key: true
  end
end
