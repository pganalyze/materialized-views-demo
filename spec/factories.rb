FactoryBot.define do
  factory :team do
    name { "Toronto Maple Leafs" }
  end

  factory :player do
    name { "Dougie Gilmour" }
    position { "F" }
  end

  factory :roster_spot do
    team
    player
    season { "2018/2019" }
  end

  factory :match do
    association :home_team, factory: :team
    association :away_team, factory: :team, name: "Ottawa Senators"
    match_time { Time.zone.parse("2018-01-01 01:01:01") }
    season { "2018/2019" }
  end

  factory :goal do
    match
    team
    player
    period { 1 }
    minute { 2 }
    second { 3 }
  end
end