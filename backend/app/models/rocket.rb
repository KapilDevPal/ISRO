class Rocket < ApplicationRecord
  belongs_to :organization
  has_many :launches, dependent: :destroy
  
  has_many :mission_rockets, dependent: :destroy
  has_many :space_missions, through: :mission_rockets
  
  validates :name, presence: true
  validates :mass, numericality: { greater_than: 0 }
  validates :payload_capacity, numericality: { greater_than: 0 }
  validates :height, numericality: { greater_than: 0 }
  validates :diameter, numericality: { greater_than: 0 }
  validates :stages, numericality: { greater_than: 0 }
  
  scope :active, -> { where(status: 'active') }
  scope :retired, -> { where(status: 'retired') }
  scope :by_organization, ->(org_id) { where(organization_id: org_id) }
  scope :by_payload_capacity, ->(min_capacity) { where('payload_capacity >= ?', min_capacity) }
  
  def launch_count
    launches.count
  end
  
  def success_rate
    return 0 if launches.count == 0
    successful_launches = launches.where(status: 'success').count
    (successful_launches.to_f / launches.count * 100).round(1)
  end
  
  def volume
    Math::PI * (diameter / 2) ** 2 * height
  end
  
  def mass_to_payload_ratio
    return 0 if payload_capacity == 0
    (mass / payload_capacity).round(2)
  end
end
