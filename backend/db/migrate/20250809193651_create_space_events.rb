class CreateSpaceEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :space_events do |t|
      t.string :name, null: false
      t.text :description
      t.datetime :event_date, null: false
      t.string :category, default: 'milestone'

      t.timestamps
    end
    
    add_index :space_events, :event_date
    add_index :space_events, :category
  end
end
