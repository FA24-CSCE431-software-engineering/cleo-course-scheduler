class CreateTracks < ActiveRecord::Migration[7.2]
  def change
    create_table :tracks do |t|
      t.string :tname, limit: 255

      t.timestamps
    end
  end
end
