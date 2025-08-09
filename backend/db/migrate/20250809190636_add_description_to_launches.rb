class AddDescriptionToLaunches < ActiveRecord::Migration[8.0]
  def change
    add_column :launches, :description, :text
  end
end
