class LaunchSite < ApplicationRecord
  belongs_to :organization
  
  validates :name, presence: true
  validates :country, presence: true
  validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }, allow_nil: true
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }, allow_nil: true
  validates :total_launches, numericality: { greater_than_or_equal_to: 0 }
  
  scope :by_country, ->(country) { where(country: country) }
  scope :most_active, -> { order(total_launches: :desc) }
  scope :recent_activity, -> { where('total_launches > 0').order(total_launches: :desc) }
  
  def coordinates
    return nil unless latitude && longitude
    "#{latitude}, #{longitude}"
  end
  
  def activity_level
    case total_launches
    when 0..10
      'Low'
    when 11..50
      'Medium'
    when 51..100
      'High'
    else
      'Very High'
    end
  end
end 