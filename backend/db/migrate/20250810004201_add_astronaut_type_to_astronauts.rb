class AddAstronautTypeToAstronauts < ActiveRecord::Migration[8.0]
  def change
    add_column :astronauts, :astronaut_type, :string
  end
end
