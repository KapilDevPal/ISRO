class Astronaut < ApplicationRecord
  belongs_to :organization
  
  has_many :astronaut_missions, dependent: :destroy
  has_many :space_missions, through: :astronaut_missions
  
  validates :name, presence: true
  validates :nationality, presence: true
  validates :status, inclusion: { in: %w[active retired deceased] }
  
  scope :active, -> { where(status: 'active') }
  scope :retired, -> { where(status: 'retired') }
  scope :deceased, -> { where(status: 'deceased') }
  scope :by_nationality, ->(nationality) { where(nationality: nationality) }
  
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
end 