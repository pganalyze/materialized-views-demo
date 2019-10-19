class CreateRosterSpots < ActiveRecord::Migration[6.0]
  def change
    create_table :roster_spots do |t|
      t.references :team, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.string :season, null: false

      t.timestamps
    end

    add_index :roster_spots, :season
    add_index :roster_spots, [:team_id, :player_id, :season], unique: true
  end
end
