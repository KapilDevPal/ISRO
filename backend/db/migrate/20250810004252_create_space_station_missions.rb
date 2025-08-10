class CreateSpaceStationMissions < ActiveRecord::Migration[8.0]
  def change
    create_table :space_station_missions do |t|
      t.references :space_station, null: false, foreign_key: true
      t.references :space_mission, null: false, foreign_key: true

      t.timestamps
    end
  end
end
