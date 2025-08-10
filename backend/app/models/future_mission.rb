class FutureMission < ApplicationRecord
  validates :mission_name, presence: true
  validates :planned_stages, presence: true
  validates :organization, presence: true
  
  scope :upcoming, -> { where('target_date >= ?', Date.current).order(:target_date) }
  scope :by_organization, ->(org) { where(organization: org) }
  scope :recently_announced, -> { where('created_at >= ?', 1.year.ago).order(created_at: :desc) }
  
  MISSION_TYPES = %w[
    satellite_launch
    crewed_mission
    lunar_mission
    mars_mission
    space_station_mission
    probe_mission
    rover_mission
    sample_return
    technology_demonstration
    earth_observation
    communication
    navigation
    scientific_research
    commercial
    military
    educational
    international_cooperation
  ].freeze
  
  def is_upcoming?
    target_date && target_date >= Date.current
  end
  
  def days_until_launch
    return nil unless target_date
    (target_date.to_date - Date.current).to_i
  end
  
  def display_target_date
    target_date&.strftime('%B %d, %Y') || 'TBD'
  end
  
  def organization_display_name
    case organization.downcase
    when 'isro'
      'ISRO (Indian Space Research Organisation)'
    when 'nasa'
      'NASA (National Aeronautics and Space Administration)'
    when 'esa'
      'ESA (European Space Agency)'
    when 'roscosmos'
      'Roscosmos (Russian Space Agency)'
    when 'cnsa'
      'CNSA (China National Space Administration)'
    when 'jaxa'
      'JAXA (Japan Aerospace Exploration Agency)'
    else
      organization
    end
  end
end 