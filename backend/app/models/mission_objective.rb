class MissionObjective < ApplicationRecord
  belongs_to :space_mission
  
  validates :name, presence: true
  validates :objective_type, presence: true
  validates :color_code, presence: true
  validates :priority, numericality: { greater_than: 0, less_than_or_equal_to: 5 }
  
  scope :primary, -> { where(is_primary: true) }
  scope :by_category, ->(objective_type) { where(objective_type: objective_type) }
  scope :by_priority, -> { order(:priority) }
  
  CATEGORIES = %w[
    communication
    exploration
    climate_monitoring
    scientific_research
    technology_demonstration
    earth_observation
    lunar_exploration
    mars_exploration
    space_station_support
    satellite_deployment
    crew_transport
    cargo_delivery
    space_tourism
    asteroid_mining
    deep_space_exploration
  ].freeze
  
  COLOR_CODES = {
    'communication' => '#3B82F6',      # Blue
    'exploration' => '#10B981',        # Green
    'climate_monitoring' => '#059669', # Emerald
    'scientific_research' => '#8B5CF6', # Purple
    'technology_demonstration' => '#F59E0B', # Amber
    'earth_observation' => '#06B6D4',  # Cyan
    'lunar_exploration' => '#6B7280', # Gray
    'mars_exploration' => '#DC2626',   # Red
    'space_station_support' => '#7C3AED', # Violet
    'satellite_deployment' => '#2563EB', # Blue
    'crew_transport' => '#059669',     # Green
    'cargo_delivery' => '#D97706',     # Orange
    'space_tourism' => '#EC4899',      # Pink
    'asteroid_mining' => '#B45309',    # Amber
    'deep_space_exploration' => '#1E40AF' # Blue
  }.freeze
  
  def category_color
    COLOR_CODES[objective_type] || '#6B7280'
  end
  
  def is_high_priority?
    priority <= 2
  end
  
  def is_low_priority?
    priority >= 4
  end
  
  def display_priority
    case priority
    when 1
      'Critical'
    when 2
      'High'
    when 3
      'Medium'
    when 4
      'Low'
    when 5
      'Optional'
    else
      'Unknown'
    end
  end
end 