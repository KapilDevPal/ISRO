class MissionOrganization < ApplicationRecord
  belongs_to :space_mission
  belongs_to :organization
  
  validates :space_mission_id, uniqueness: { scope: :organization_id }
end 