class CreateMissionSatellites < ActiveRecord::Migration[8.0]
  def change
    create_table :mission_satellites do |t|
      t.references :space_mission, null: false, foreign_key: true
      t.references :satellite, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :mission_satellites, [:space_mission_id, :satellite_id], unique: true, name: 'index_mission_satellites_unique'
  end
end
