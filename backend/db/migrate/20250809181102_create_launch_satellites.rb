class CreateLaunchSatellites < ActiveRecord::Migration[8.0]
  def change
    create_table :launch_satellites do |t|
      t.references :launch, null: false, foreign_key: true
      t.references :satellite, null: false, foreign_key: true

      t.timestamps
    end
  end
end
