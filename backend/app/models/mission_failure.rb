class MissionFailure < ApplicationRecord
  validates :mission_name, presence: true
  validates :failed_stage, presence: true
  validates :organization, presence: true
  
  scope :by_organization, ->(org) { where(organization: org) }
  scope :by_date, -> { order(:failure_date) }
  scope :recent, -> { where('failure_date >= ?', 5.years.ago).order(failure_date: :desc) }
  scope :by_stage, ->(stage) { where(failed_stage: stage) }
  
  FAILURE_STAGES = %w[
    pre_launch
    first_stage
    second_stage
    third_stage
    fairing_separation
    satellite_deployment
    orbital_insertion
    mid_course_correction
    landing
    communication_loss
    power_system
    guidance_system
    propulsion_system
    thermal_control
    unknown
  ].freeze
  
  FAILURE_CATEGORIES = %w[
    technical
    human_error
    software
    hardware
    environmental
    communication
    power
    propulsion
    guidance
    structural
    unknown
  ].freeze
  
  def is_recent?
    failure_date && failure_date >= 5.years.ago
  end
  
  def failure_age_years
    return nil unless failure_date
    ((Date.current - failure_date) / 365.25).to_i
  end
  
  def display_failure_date
    failure_date&.strftime('%B %d, %Y') || 'Unknown'
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