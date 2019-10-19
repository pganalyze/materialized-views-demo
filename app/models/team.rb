class Team < ApplicationRecord
  has_many :roster_spots
  has_many :players, through: :roster_spots
end
