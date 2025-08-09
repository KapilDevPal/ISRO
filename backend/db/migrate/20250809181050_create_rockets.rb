class CreateRockets < ActiveRecord::Migration[8.0]
  def change
    create_table :rockets do |t|
      t.string :name
      t.references :organization, null: false, foreign_key: true
      t.decimal :mass
      t.decimal :payload_capacity
      t.decimal :height
      t.decimal :diameter
      t.integer :stages
      t.text :description
      t.string :image_url
      t.string :model_url
      t.string :status
      t.date :first_flight

      t.timestamps
    end
  end
end
