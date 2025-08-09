class Organization < ApplicationRecord
  self.inheritance_column = nil
  
  has_many :rockets, dependent: :destroy
  has_many :satellites, dependent: :destroy
  has_many :launches, through: :rockets

  validates :name, presence: true, uniqueness: true
  validates :country, presence: true
  validates :type, presence: true

  scope :active, -> { where(status: 'active') }
  scope :by_country, ->(country) { where(country: country) }
  scope :by_type, ->(type) { where(type: type) }

  def rocket_count
    rockets.count
  end

  def satellite_count
    satellites.count
  end

  def launch_count
    launches.count
  end
end
