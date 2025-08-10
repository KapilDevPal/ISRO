class Astronaut < ApplicationRecord
  belongs_to :organization
  
  has_many :astronaut_missions, dependent: :destroy
  has_many :space_missions, through: :astronaut_missions
  
  has_many :crew_modules, dependent: :destroy
  
  validates :name, presence: true
  validates :nationality, presence: true
  validates :status, inclusion: { in: %w[active retired deceased] }
  
  scope :active, -> { where(status: 'active') }
  scope :retired, -> { where(status: 'retired') }
  scope :deceased, -> { where(status: 'deceased') }
  scope :by_nationality, ->(nationality) { where(nationality: nationality) }
  scope :by_type, ->(type) { where(astronaut_type: type) }
  
  ASTRONAUT_TYPES = {
    'astronaut' => 'Astronaut (US/ESA)',
    'cosmonaut' => 'Cosmonaut (Russia)',
    'taikonaut' => 'Taikonaut (China)',
    'vyomanaut' => 'Vyomanaut (India)',
    'spationaute' => 'Spationaute (France)',
    'uchu_hikoshi' => 'Uchū Hikō-shi (Japan)',
    'astronauta' => 'Astronauta (Italy)',
    'uju_won' => 'Uju-won (Korea)',
    'kavoshgar' => 'Kavoshgar (Iran)',
    'angkasawan' => 'Angkasawan (Malaysia)',
    'astronauta_br' => 'Astronauta (Brazil)',
    'uju_ryughaeng_won' => 'Uju-ryughaeng-won (North Korea)'
  }.freeze
  
  def mission_count
    space_missions.count
  end
  
  def active_missions
    space_missions.ongoing
  end
  
  def completed_missions
    space_missions.completed
  end
  
  def status_color
    case status
    when 'active'
      'green'
    when 'retired'
      'blue'
    when 'deceased'
      'red'
    else
      'gray'
    end
  end
  
  def display_name
    "#{name} (#{nationality})"
  end
  
  def astronaut_type_display
    ASTRONAUT_TYPES[astronaut_type] || astronaut_type&.titleize || 'Unknown'
  end
  
  def current_crew_module
    crew_modules.active.first
  end
  
  def total_flight_hours
    # This would need to be calculated from mission data
    # For now, returning a placeholder
    0
  end
  
  def space_walks_count
    # This would need to be tracked separately
    # For now, returning a placeholder
    0
  end
end 