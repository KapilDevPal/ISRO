class CreateAstronautMissions < ActiveRecord::Migration[8.0]
  def change
    create_table :astronaut_missions do |t|
      t.references :astronaut, null: false, foreign_key: true
      t.references :space_mission, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :astronaut_missions, [:astronaut_id, :space_mission_id], unique: true, name: 'index_astronaut_missions_unique'
  end
end
