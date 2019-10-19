class Goal < ApplicationRecord
  belongs_to :match
  belongs_to :team
  belongs_to :player
end
