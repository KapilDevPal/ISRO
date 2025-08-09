class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :country
      t.string :type
      t.text :description
      t.string :website
      t.string :logo_url

      t.timestamps
    end
  end
end
