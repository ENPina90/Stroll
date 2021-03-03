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
      t.string :date
      t.string :creator
      t.text :intro
      t.text :content
      t.text :facts
      t.string :photo_url
      t.string :photo_caption
      t.string :sources
      t.string :lang
      t.timestamps
    end
  end
end
