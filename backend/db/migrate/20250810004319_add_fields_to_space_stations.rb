class AddFieldsToSpaceStations < ActiveRecord::Migration[8.0]
  def change
    add_column :space_stations, :country, :string
    add_column :space_stations, :orbit_type, :string
    add_column :space_stations, :altitude, :decimal
    add_column :space_stations, :inclination, :decimal
    add_column :space_stations, :mass, :decimal
    add_column :space_stations, :length, :decimal
    add_column :space_stations, :width, :decimal
    add_column :space_stations, :height, :decimal
  end
end
