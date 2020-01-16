class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.references :match, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.integer :period, null: false
      t.integer :minute, null: false
      t.integer :second, null: false

      t.timestamps
    end
  end
end
