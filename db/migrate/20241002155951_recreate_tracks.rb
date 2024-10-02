class RecreateTracks < ActiveRecord::Migration[7.2]
  def change
    drop_table :tracks

    create_table :tracks do |t|
      t.string :tname, limit: 255, null: false

      t.timestamps
    end
  end
end
