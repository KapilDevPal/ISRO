class Rocket < ApplicationRecord
  belongs_to :organization
  has_many :launches, dependent: :destroy

  validates :name, presence: true
  validates :mass, numericality: { greater_than: 0 }, allow_nil: true
  validates :payload_capacity, numericality: { greater_than: 0 }, allow_nil: true
  validates :height, numericality: { greater_than: 0 }, allow_nil: true
  validates :diameter, numericality: { greater_than: 0 }, allow_nil: true
  validates :stages, numericality: { greater_than: 0 }, allow_nil: true

  scope :active, -> { where(status: 'active') }
  scope :by_organization, ->(org_id) { where(organization_id: org_id) }
  scope :by_status, ->(status) { where(status: status) }

  def launch_count
    launches.count
  end

  def successful_launches
    launches.where(outcome: 'success').count
  end

  def success_rate
    return 0 if launches.count.zero?
    (successful_launches.to_f / launches.count * 100).round(2)
  end
end
