class CreateMissionOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :mission_organizations do |t|
      t.references :space_mission, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :mission_organizations, [:space_mission_id, :organization_id], unique: true, name: 'index_mission_orgs_unique'
  end
end
