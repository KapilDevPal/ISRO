class CreateNews < ActiveRecord::Migration[8.0]
  def change
    create_table :news do |t|
      t.string :title
      t.string :source
      t.string :url
      t.datetime :published_at
      t.text :summary
      t.string :image_url
      t.string :category

      t.timestamps
    end
  end
end
