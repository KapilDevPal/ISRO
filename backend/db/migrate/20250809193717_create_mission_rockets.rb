class CreateMissionRockets < ActiveRecord::Migration[8.0]
  def change
    create_table :mission_rockets do |t|
      t.references :space_mission, null: false, foreign_key: true
      t.references :rocket, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :mission_rockets, [:space_mission_id, :rocket_id], unique: true, name: 'index_mission_rockets_unique'
  end
end
