class CreateEndingLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :ending_locations do |t|
      t.references :walk, null: false, foreign_key: true
      t.string :address

      t.timestamps
    end
  end
end
