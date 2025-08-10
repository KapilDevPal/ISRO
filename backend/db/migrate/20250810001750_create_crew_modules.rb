class CreateCrewModules < ActiveRecord::Migration[8.0]
  def change
    create_table :crew_modules do |t|
      t.timestamps
    end
  end
end
