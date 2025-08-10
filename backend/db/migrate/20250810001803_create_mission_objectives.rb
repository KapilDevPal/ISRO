class CreateMissionObjectives < ActiveRecord::Migration[8.0]
  def change
    create_table :mission_objectives do |t|
      t.string :purpose, null: false
      t.string :category, null: false
      t.string :color_code, null: false
      t.text :description
      t.integer :priority, default: 1
      t.references :space_mission, null: false, foreign_key: true
      t.boolean :is_primary, default: false
      t.timestamps
    end
    
    add_index :mission_objectives, [:space_mission_id, :category]
    add_index :mission_objectives, :is_primary
  end
end
