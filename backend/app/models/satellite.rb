class Satellite < ApplicationRecord
  belongs_to :organization
  has_many :launch_satellites, dependent: :destroy
  has_many :launches, through: :launch_satellites

  validates :name, presence: true
  validates :mass, numericality: { greater_than: 0 }, allow_nil: true
  validates :height, numericality: { greater_than: 0 }, allow_nil: true
  validates :width, numericality: { greater_than: 0 }, allow_nil: true
  validates :depth, numericality: { greater_than: 0 }, allow_nil: true

  scope :active, -> { where(status: 'active') }
  scope :by_organization, ->(org_id) { where(organization_id: org_id) }
  scope :by_orbit_type, ->(orbit_type) { where(orbit_type: orbit_type) }
  scope :by_status, ->(status) { where(status: status) }
  scope :recent, -> { where('launch_date >= ?', 1.year.ago) }

  def launch_count
    launches.count
  end

  def age_in_days
    return nil unless launch_date
    (Date.current - launch_date.to_date).to_i
  end
end
