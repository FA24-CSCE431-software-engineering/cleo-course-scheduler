# frozen_string_literal: true

class RecreateEmphases < ActiveRecord::Migration[7.2]
  def change
    drop_table :emphases

    create_table :emphases do |t|
      t.string :ename, limit: 255, null: false

      t.timestamps
    end
  end
end
