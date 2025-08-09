class SpaceStatistic < ApplicationRecord
  validates :satellites_in_orbit, :active_astronauts, :launches_this_year, :reusable_landings, 
            numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  
  validates :last_updated, presence: true
  
  scope :latest, -> { order(last_updated: :desc).first }
  
  def self.current_stats
    latest || create_default_stats
  end
  
  def self.create_default_stats
    create!(
      satellites_in_orbit: 0,
      active_astronauts: 0,
      launches_this_year: 0,
      reusable_landings: 0,
      last_updated: Date.current
    )
  end
  
  def update_stats(satellites: nil, astronauts: nil, launches: nil, landings: nil)
    update!(
      satellites_in_orbit: satellites || satellites_in_orbit,
      active_astronauts: astronauts || active_astronauts,
      launches_this_year: launches || launches_this_year,
      reusable_landings: landings || reusable_landings,
      last_updated: Date.current
    )
  end
end 