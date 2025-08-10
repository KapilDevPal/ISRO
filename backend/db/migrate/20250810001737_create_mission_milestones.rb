class CreateMissionMilestones < ActiveRecord::Migration[8.0]
  def change
    create_table :mission_milestones do |t|
      t.timestamps
    end
  end
end
