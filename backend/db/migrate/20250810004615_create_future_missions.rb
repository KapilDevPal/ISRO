class CreateFutureMissions < ActiveRecord::Migration[8.0]
  def change
    create_table :future_missions do |t|
      t.timestamps
    end
  end
end
