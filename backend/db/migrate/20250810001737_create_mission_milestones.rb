class CreateMissionMilestones < ActiveRecord::Migration[8.0]
  def change
    create_table :mission_milestones do |t|
      t.string :title, null: false
      t.text :description
      t.date :milestone_date, null: false
      t.string :stage, null: false
      t.string :status, default: 'planned'
      t.references :space_mission, null: false, foreign_key: true
      t.integer :order_sequence
      t.timestamps
    end
    
    add_index :mission_milestones, [:space_mission_id, :milestone_date]
    add_index :mission_milestones, :stage
  end
end
