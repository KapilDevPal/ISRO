class AstronautMission < ApplicationRecord
  belongs_to :astronaut
  belongs_to :space_mission
  
  validates :astronaut_id, uniqueness: { scope: :space_mission_id }
end 