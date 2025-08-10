class AddAdditionalFieldsToSpaceMissions < ActiveRecord::Migration[8.0]
  def change
    add_reference :space_missions, :organization, null: false, foreign_key: true
    add_column :space_missions, :mission_type, :string
    add_column :space_missions, :description, :text
    add_column :space_missions, :launch_date, :datetime
    add_reference :space_missions, :rocket, null: false, foreign_key: true
    add_reference :space_missions, :satellite, null: false, foreign_key: true
  end
end
