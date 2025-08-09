class SpaceEvent < ApplicationRecord
  has_many :space_event_organizations, dependent: :destroy
  has_many :organizations, through: :space_event_organizations
  
  validates :name, presence: true
  validates :event_date, presence: true
  validates :category, inclusion: { in: %w[milestone disaster astronomical_event] }
  
  scope :milestones, -> { where(category: 'milestone') }
  scope :disasters, -> { where(category: 'disaster') }
  scope :astronomical_events, -> { where(category: 'astronomical_event') }
  scope :recent, -> { order(event_date: :desc) }
  scope :chronological, -> { order(event_date: :asc) }
  
  def years_ago
    return nil unless event_date
    (Date.current - event_date.to_date).to_i / 365
  end
  
  def category_color
    case category
    when 'milestone'
      'green'
    when 'disaster'
      'red'
    when 'astronomical_event'
      'blue'
    else
      'gray'
    end
  end
end 