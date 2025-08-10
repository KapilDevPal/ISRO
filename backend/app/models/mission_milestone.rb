class MissionMilestone < ApplicationRecord
  belongs_to :space_mission
  
  validates :name, presence: true
  validates :event_date, presence: true
  validates :milestone_type, presence: true
  validates :status, inclusion: { in: %w[planned in_progress completed delayed cancelled] }
  
  scope :by_date, -> { order(:event_date) }
  scope :by_stage, ->(milestone_type) { where(milestone_type: milestone_type) }
  scope :upcoming, -> { where('event_date >= ?', Date.current).order(:event_date) }
  scope :completed, -> { where(status: 'completed') }
  
  def is_completed?
    status == 'completed'
  end
  
  def is_delayed?
    status == 'delayed'
  end
  
  def is_upcoming?
    event_date >= Date.current
  end
  
  def status_color
    case status
    when 'planned'
      'blue'
    when 'in_progress'
      'yellow'
    when 'completed'
      'green'
    when 'delayed'
      'orange'
    when 'cancelled'
      'red'
    else
      'gray'
    end
  end
end 