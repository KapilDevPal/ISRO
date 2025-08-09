class CreateLaunchSites < ActiveRecord::Migration[8.0]
  def change
    create_table :launch_sites do |t|
      t.string :name, null: false
      t.string :country, null: false
      t.float :latitude
      t.float :longitude
      t.integer :total_launches, default: 0
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :launch_sites, :country
    add_index :launch_sites, :total_launches
  end
end
