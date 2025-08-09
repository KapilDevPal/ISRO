class LaunchSatellite < ApplicationRecord
  belongs_to :launch
  belongs_to :satellite

  validates :launch_id, uniqueness: { scope: :satellite_id }
end
