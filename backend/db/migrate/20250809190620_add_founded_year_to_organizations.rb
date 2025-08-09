class AddFoundedYearToOrganizations < ActiveRecord::Migration[8.0]
  def change
    add_column :organizations, :founded_year, :integer
  end
end
