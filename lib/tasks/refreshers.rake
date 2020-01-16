namespace :refreshers do
  desc "Refresh materialized view for top scorers"
  task mat_top_scorers: :environment do
    MatTopScorer.refresh
  end
end