class CreateEmphases < ActiveRecord::Migration[7.2]
  def change
    create_table :emphases do |t|
      t.string :ename, limit: 255

      t.timestamps
    end
  end
end
