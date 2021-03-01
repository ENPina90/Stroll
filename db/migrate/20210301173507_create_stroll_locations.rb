class CreateStrollLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :stroll_locations do |t|
      t.references :location, null: false, foreign_key: true
      t.references :walk, null: false, foreign_key: true

      t.timestamps
    end
  end
end
