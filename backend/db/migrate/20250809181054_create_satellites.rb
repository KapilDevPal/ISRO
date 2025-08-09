class CreateSatellites < ActiveRecord::Migration[8.0]
  def change
    create_table :satellites do |t|
      t.string :name
      t.references :organization, null: false, foreign_key: true
      t.decimal :mass
      t.decimal :height
      t.decimal :width
      t.decimal :depth
      t.text :purpose
      t.date :launch_date
      t.string :orbit_type
      t.string :status
      t.string :image_url
      t.string :model_url
      t.text :description

      t.timestamps
    end
  end
end
