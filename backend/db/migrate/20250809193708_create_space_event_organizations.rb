class CreateSpaceEventOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :space_event_organizations do |t|
      t.references :space_event, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :space_event_organizations, [:space_event_id, :organization_id], unique: true, name: 'index_space_event_orgs_unique'
  end
end
