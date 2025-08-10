class CreateCrewModules < ActiveRecord::Migration[8.0]
  def change
    create_table :crew_modules do |t|
      t.string :name, null: false
      t.text :description
      t.string :mission_role, null: false
      t.text :past_mission_history
      t.references :space_mission, null: false, foreign_key: true
      t.references :astronaut, null: true, foreign_key: true
      t.string :status, default: 'active'
      t.timestamps
    end
    
    add_index :crew_modules, [:space_mission_id, :astronaut_id]
    add_index :crew_modules, :mission_role
  end
end
