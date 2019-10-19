class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.bigint :home_team_id, null: false
      t.bigint :away_team_id, null: false
      t.timestamp :match_time, null: false
      t.string :season, null: false

      t.timestamps
    end

    add_index :matches, :home_team_id
    add_index :matches, :away_team_id
    add_index :matches, :season
  end
end
