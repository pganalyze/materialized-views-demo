class CreateMatTopScorers < ActiveRecord::Migration[6.0]
  def change
    create_view :mat_top_scorers, materialized: true

    add_index :mat_top_scorers, :player_name
    add_index :mat_top_scorers, :player_id
    add_index :mat_top_scorers, :team_name
    add_index :mat_top_scorers, :team_id
    add_index :mat_top_scorers, :season
  end
end
