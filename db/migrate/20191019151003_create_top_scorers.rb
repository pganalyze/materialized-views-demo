class CreateTopScorers < ActiveRecord::Migration[6.0]
  def change
    create_view :top_scorers
  end
end
