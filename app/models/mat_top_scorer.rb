class MatTopScorer < ApplicationRecord
  belongs_to :player
  belongs_to :team
  belongs_to :match

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)
  end

  def self.top_scorer_for_season(season)
    where(season: season).order(goal_count: :desc).first
  end

  def readonly?
    true
  end
end