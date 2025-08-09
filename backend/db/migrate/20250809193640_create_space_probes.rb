class CreateSpaceProbes < ActiveRecord::Migration[8.0]
  def change
    create_table :space_probes do |t|
      t.string :name, null: false
      t.string :target_destination, null: false
      t.datetime :launch_date
      t.string :status, default: 'active'
      t.text :discoveries
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :space_probes, :status
    add_index :space_probes, :launch_date
  end
end
