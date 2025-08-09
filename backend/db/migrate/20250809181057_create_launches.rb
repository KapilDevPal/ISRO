class CreateLaunches < ActiveRecord::Migration[8.0]
  def change
    create_table :launches do |t|
      t.string :name
      t.references :rocket, null: false, foreign_key: true
      t.datetime :launch_date
      t.string :launch_site
      t.text :mission_objective
      t.string :status
      t.string :outcome
      t.string :image_url
      t.string :webcast_url

      t.timestamps
    end
  end
end
