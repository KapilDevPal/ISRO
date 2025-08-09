class MissionSatellite < ApplicationRecord
  belongs_to :space_mission
  belongs_to :satellite
  
  validates :space_mission_id, uniqueness: { scope: :satellite_id }
end 