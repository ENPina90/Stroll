class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :category
      t.integer :cost
      t.integer :significance
      t.string :keywords
      t.string :info
      t.text :content
      t.string :photo_url

      t.timestamps
    end
  end
end
