team_names = [
  'Carolina Hurricanes',
  'Columbus Blue Jackets',
  'New Jersey Devils',
  'New York Islanders',
  'New York Rangers',
  'Philadephia Flyers',
  'Pittsburg Penguins',
  'Washington Capitals',
  'Boston Bruins',
  'Buffalo Sabers',
  'Detroit Red Wings',
  'Florida Panthers',
  'Montreal Canadiens',
  'Ottawa Senators',
  'Tamba Bay Lightning',
  'Toronto Maple Leafs',
  'Chicago Black Hawks',
  'Colorado Avalanche',
  'Dallas Stars',
  'Minnesota Wild',
  'Nashville Predators',
  'St. Louis Blues',
  'Winnipeg Jets',
  'Anaheim Ducks',
  'Arizona Coyotes',
  'Calgary Flames',
  'Edmonton Oilers',
  'Los Angeles Kings',
  'San Jose Sharks',
  'Vancouver Canucks',
  'Vegas Golden Knights',
]

teams = team_names.map do |name|
  Team.create!(
    name: name
  )
end

puts "Teams Created"

team_players = teams.reduce({}) do |acc, team|
  30.times do
    player = Player.create!(
      name: Faker::Name.name,
      position: ['F','F','F','D','D','D','G'].sample
    )
    RosterSpot.create!(
      team: team,
      player: player,
      season: '2018/2019'
    )
    acc[team.id] ||= []
    acc[team.id] << player
  end

  acc
end

puts "Players Created"

matches = teams.reduce([]) do |acc, team|
  200.times do |i|
    away = teams.sample
    match = Match.create!(
      home_team: team,
      away_team: away,
      match_time: Time.zone.parse('2018-01-01') + i.days,
      season: '2018/2019'
    )
    acc << match
  end

  acc
end

puts "Matches Created"

periods = [1,2,3]
minutes = (0..19).to_a
seconds = (0..59).to_a

ActiveRecord::Base.transaction do
  matches.each do |match|
    20.times do
      team = [true, false].sample ? match.home_team : match.away_team

      Goal.create!(
        match: match,
        team: team,
        player: team_players[team.id].sample,
        period: periods.sample,
        minute: minutes.sample,
        second: seconds.sample
      )
    end
  end
end

puts "Goals Created"