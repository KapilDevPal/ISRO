class CreateSpaceStations < ActiveRecord::Migration[8.0]
  def change
    create_table :space_stations do |t|
      t.string :name
      t.references :organization, null: false, foreign_key: true
      t.string :station_type
      t.text :description
      t.date :launch_date
      t.string :status
      t.decimal :orbit_altitude
      t.integer :crew_capacity

      t.timestamps
    end
  end
end
