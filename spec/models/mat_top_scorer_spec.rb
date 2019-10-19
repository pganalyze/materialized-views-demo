require 'rails_helper'

RSpec.describe MatTopScorer, type: :model do
  describe "#top_scorer_for_season" do
    it "finds top scorer" do
      match = create(:match)
      player = create(:player)
      goal = create(:goal, match: match, player: player)

      # without any data in materialized view
      expect(MatTopScorer.top_scorer_for_season(match.season)).to eq(nil)

      MatTopScorer.refresh

      # with data in materialized view
      top_scorer = MatTopScorer.top_scorer_for_season(match.season)
      expect(top_scorer).to be_present
      expect(top_scorer.player).to eq(player)
      expect(top_scorer.goal_count).to eq(1)
    end
  end
end
