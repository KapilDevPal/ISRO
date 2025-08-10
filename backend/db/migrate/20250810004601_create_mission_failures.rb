class CreateMissionFailures < ActiveRecord::Migration[8.0]
  def change
    create_table :mission_failures do |t|
      t.string :mission_name, null: false
      t.string :failed_stage, null: false
      t.text :notes
      t.date :failure_date
      t.string :organization, null: false
      t.string :mission_type
      t.string :failure_category
      t.timestamps
    end
    
    add_index :mission_failures, :organization
    add_index :mission_failures, :failure_date
    add_index :mission_failures, :failed_stage
  end
end
