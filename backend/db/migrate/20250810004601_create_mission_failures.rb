class CreateMissionFailures < ActiveRecord::Migration[8.0]
  def change
    create_table :mission_failures do |t|
      t.timestamps
    end
  end
end
