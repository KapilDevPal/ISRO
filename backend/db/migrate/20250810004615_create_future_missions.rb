class CreateFutureMissions < ActiveRecord::Migration[8.0]
  def change
    create_table :future_missions do |t|
      t.string :mission_name, null: false
      t.text :planned_stages, null: false
      t.string :organization, null: false
      t.date :planned_date
      t.string :mission_type
      t.text :description
      t.string :status, default: 'planned'
      t.timestamps
    end
    
    add_index :future_missions, :organization
    add_index :future_missions, :planned_date
    add_index :future_missions, :status
  end
end
