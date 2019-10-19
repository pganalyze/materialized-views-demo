select
  players.name as player_name,
  players.id as player_id,
  players.position as player_position,
  matches.season as season,
  teams.name as team_name,
  teams.id as team_id,
  count(goals.id) as goal_count
from goals
  inner join players on goals.player_id = players.id
  inner join matches on goals.match_id = matches.id
  inner join teams on goals.team_id = teams.id
group by players.id, teams.id, matches.season
