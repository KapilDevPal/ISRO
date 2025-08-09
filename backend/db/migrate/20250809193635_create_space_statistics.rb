class CreateSpaceStatistics < ActiveRecord::Migration[8.0]
  def change
    create_table :space_statistics do |t|
      t.integer :satellites_in_orbit, default: 0
      t.integer :active_astronauts, default: 0
      t.integer :launches_this_year, default: 0
      t.integer :reusable_landings, default: 0
      t.date :last_updated

      t.timestamps
    end
  end
end
