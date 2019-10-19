# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_19_152542) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "goals", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "team_id", null: false
    t.bigint "player_id", null: false
    t.integer "period", null: false
    t.integer "minute", null: false
    t.integer "second", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_goals_on_match_id"
    t.index ["player_id"], name: "index_goals_on_player_id"
    t.index ["team_id"], name: "index_goals_on_team_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "home_team_id", null: false
    t.bigint "away_team_id", null: false
    t.datetime "match_time", null: false
    t.string "season", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["away_team_id"], name: "index_matches_on_away_team_id"
    t.index ["home_team_id"], name: "index_matches_on_home_team_id"
    t.index ["season"], name: "index_matches_on_season"
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.string "position", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_players_on_name"
  end

  create_table "roster_spots", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "player_id", null: false
    t.string "season", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_roster_spots_on_player_id"
    t.index ["season"], name: "index_roster_spots_on_season"
    t.index ["team_id", "player_id", "season"], name: "index_roster_spots_on_team_id_and_player_id_and_season", unique: true
    t.index ["team_id"], name: "index_roster_spots_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_teams_on_name"
  end

  add_foreign_key "goals", "matches"
  add_foreign_key "goals", "players"
  add_foreign_key "goals", "teams"
  add_foreign_key "roster_spots", "players"
  add_foreign_key "roster_spots", "teams"

  create_view "top_scorers", sql_definition: <<-SQL
      SELECT players.name AS player_name,
      players.id AS player_id,
      players."position" AS player_position,
      matches.season,
      teams.name AS team_name,
      teams.id AS team_id,
      count(goals.id) AS goal_count
     FROM (((goals
       JOIN players ON ((goals.player_id = players.id)))
       JOIN matches ON ((goals.match_id = matches.id)))
       JOIN teams ON ((goals.team_id = teams.id)))
    GROUP BY players.id, teams.id, matches.season;
  SQL
  create_view "mat_top_scorers", materialized: true, sql_definition: <<-SQL
      SELECT players.name AS player_name,
      players.id AS player_id,
      players."position" AS player_position,
      matches.season,
      teams.name AS team_name,
      teams.id AS team_id,
      count(goals.id) AS goal_count
     FROM (((goals
       JOIN players ON ((goals.player_id = players.id)))
       JOIN matches ON ((goals.match_id = matches.id)))
       JOIN teams ON ((goals.team_id = teams.id)))
    GROUP BY players.id, teams.id, matches.season;
  SQL
  add_index "mat_top_scorers", ["player_id"], name: "index_mat_top_scorers_on_player_id"
  add_index "mat_top_scorers", ["player_name"], name: "index_mat_top_scorers_on_player_name"
  add_index "mat_top_scorers", ["season"], name: "index_mat_top_scorers_on_season"
  add_index "mat_top_scorers", ["team_id"], name: "index_mat_top_scorers_on_team_id"
  add_index "mat_top_scorers", ["team_name"], name: "index_mat_top_scorers_on_team_name"

end
