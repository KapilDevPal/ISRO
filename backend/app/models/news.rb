class News < ApplicationRecord
  validates :title, presence: true
  validates :source, presence: true
  validates :url, presence: true, format: { with: URI::regexp }
  validates :published_at, presence: true
  validates :category, presence: true

  scope :recent, -> { where('published_at >= ?', 1.week.ago).order(published_at: :desc) }
  scope :by_category, ->(category) { where(category: category) }
  scope :by_source, ->(source) { where(source: source) }
  scope :featured, -> { where(category: 'featured').order(published_at: :desc) }

  def published_date
    published_at&.strftime('%B %d, %Y')
  end

  def time_ago
    return 'Unknown' unless published_at
    
    seconds = Time.current - published_at
    minutes = (seconds / 60).to_i
    hours = (minutes / 60).to_i
    days = (hours / 24).to_i
    
    if days > 0
      "#{days} day#{days == 1 ? '' : 's'} ago"
    elsif hours > 0
      "#{hours} hour#{hours == 1 ? '' : 's'} ago"
    elsif minutes > 0
      "#{minutes} minute#{minutes == 1 ? '' : 's'} ago"
    else
      "Just now"
    end
  end
end
