# frozen_string_literal: true

class ChangeGoogleIdToStringInStudents < ActiveRecord::Migration[7.2]
  def change
    change_column :students, :google_id, :string
  end
end
