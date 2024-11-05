# frozen_string_literal: true

class FixStudentEmphasisId < ActiveRecord::Migration[7.2]
  def change
    rename_column :students, :emphases_id, :emphasis_id
  end
end
