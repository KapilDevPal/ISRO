class AddAdditionalFieldsToAstronauts < ActiveRecord::Migration[8.0]
  def change
    add_column :astronauts, :astronaut_title, :string
    add_column :astronauts, :birth_date, :date
    add_column :astronauts, :death_date, :date
    add_column :astronauts, :missions_count, :integer
    add_column :astronauts, :description, :text
  end
end
