class Launch < ApplicationRecord
  belongs_to :rocket
  has_many :launch_satellites, dependent: :destroy
  has_many :satellites, through: :launch_satellites

  validates :name, presence: true
  validates :launch_date, presence: true
  validates :launch_site, presence: true
  validates :status, presence: true

  scope :upcoming, -> { where('launch_date > ?', Time.current).order(:launch_date) }
  scope :past, -> { where('launch_date <= ?', Time.current).order(launch_date: :desc) }
  scope :by_status, ->(status) { where(status: status) }
  scope :by_rocket, ->(rocket_id) { where(rocket_id: rocket_id) }
  scope :by_site, ->(site) { where(launch_site: site) }
  scope :recent, -> { where('launch_date >= ?', 1.month.ago) }

  def countdown_seconds
    return 0 if launch_date <= Time.current
    (launch_date - Time.current).to_i
  end

  def is_upcoming?
    launch_date > Time.current
  end

  def is_upcoming
    is_upcoming?
  end

  def is_past?
    launch_date <= Time.current
  end

  def is_past
    is_past?
  end

  def days_until_launch
    return nil if is_past?
    ((launch_date - Time.current) / 1.day).ceil
  end
end
