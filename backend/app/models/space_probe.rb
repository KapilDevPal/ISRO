class SpaceProbe < ApplicationRecord
  belongs_to :organization
  
  validates :name, presence: true
  validates :target_destination, presence: true
  validates :status, inclusion: { in: %w[active completed retired] }
  
  scope :active, -> { where(status: 'active') }
  scope :completed, -> { where(status: 'completed') }
  scope :retired, -> { where(status: 'retired') }
  scope :recent, -> { order(launch_date: :desc) }
  
  def age_in_days
    return nil unless launch_date
    (Date.current - launch_date.to_date).to_i
  end
  
  def status_color
    case status
    when 'active'
      'green'
    when 'completed'
      'blue'
    when 'retired'
      'red'
    else
      'gray'
    end
  end
end 