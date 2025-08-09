class MissionRocket < ApplicationRecord
  belongs_to :space_mission
  belongs_to :rocket
  
  validates :space_mission_id, uniqueness: { scope: :rocket_id }
end 