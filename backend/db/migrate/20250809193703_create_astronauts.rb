class CreateAstronauts < ActiveRecord::Migration[8.0]
  def change
    create_table :astronauts do |t|
      t.string :name, null: false
      t.string :nationality, null: false
      t.text :bio
      t.string :image_url
      t.string :status, default: 'active'
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :astronauts, :nationality
    add_index :astronauts, :status
  end
end
