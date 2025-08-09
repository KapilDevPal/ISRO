class SpaceMission < ApplicationRecord
  has_many :mission_organizations, dependent: :destroy
  has_many :organizations, through: :mission_organizations
  
  has_many :mission_rockets, dependent: :destroy
  has_many :rockets, through: :mission_rockets
  
  has_many :mission_satellites, dependent: :destroy
  has_many :satellites, through: :mission_satellites
  
  has_many :astronaut_missions, dependent: :destroy
  has_many :astronauts, through: :astronaut_missions
  
  validates :name, presence: true
  validates :status, inclusion: { in: %w[planned ongoing completed] }
  validates :start_date, presence: true
  
  scope :planned, -> { where(status: 'planned') }
  scope :ongoing, -> { where(status: 'ongoing') }
  scope :completed, -> { where(status: 'completed') }
  scope :recent, -> { order(start_date: :desc) }
  scope :upcoming, -> { where('start_date > ?', Date.current).order(start_date: :asc) }
  
  def duration_days
    return nil unless start_date && end_date
    (end_date.to_date - start_date.to_date).to_i
  end
  
  def is_active?
    status == 'ongoing'
  end
  
  def is_completed?
    status == 'completed'
  end
  
  def is_planned?
    status == 'planned'
  end
  
  def status_color
    case status
    when 'planned'
      'yellow'
    when 'ongoing'
      'green'
    when 'completed'
      'blue'
    else
      'gray'
    end
  end
end 