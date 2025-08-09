class CreateSpaceMissions < ActiveRecord::Migration[8.0]
  def change
    create_table :space_missions do |t|
      t.string :name, null: false
      t.text :objective
      t.datetime :start_date
      t.datetime :end_date
      t.string :status, default: 'planned'

      t.timestamps
    end
    
    add_index :space_missions, :status
    add_index :space_missions, :start_date
  end
end
