# frozen_string_literal: true

class RecreateCoreCategories < ActiveRecord::Migration[7.2]
  def change
    drop_table :core_categories

    create_table :core_categories do |t|
      t.string :cname, limit: 255, null: false

      t.timestamps
    end
  end
end
