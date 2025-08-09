class SpaceEventOrganization < ApplicationRecord
  belongs_to :space_event
  belongs_to :organization
  
  validates :space_event_id, uniqueness: { scope: :organization_id }
end 