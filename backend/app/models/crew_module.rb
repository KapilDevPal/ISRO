class CrewModule < ApplicationRecord
  belongs_to :space_mission
  belongs_to :astronaut, optional: true
  
  validates :name, presence: true
  validates :mission_role, presence: true
  validates :status, inclusion: { in: %w[active inactive assigned unassigned] }
  
  scope :active, -> { where(status: 'active') }
  scope :assigned, -> { where(status: 'assigned') }
  scope :by_role, ->(role) { where(mission_role: role) }
  
  def is_assigned?
    astronaut.present?
  end
  
  def astronaut_name
    astronaut&.name || 'Unassigned'
  end
  
  def nationality
    astronaut&.nationality
  end
  
  def astronaut_type
    astronaut&.astronaut_type
  end
  
  def mission_count
    astronaut&.mission_count || 0
  end
  
  def status_color
    case status
    when 'active'
      'green'
    when 'assigned'
      'blue'
    when 'inactive'
      'gray'
    when 'unassigned'
      'yellow'
    else
      'gray'
    end
  end
end 