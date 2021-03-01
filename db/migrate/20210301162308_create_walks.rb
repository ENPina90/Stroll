class CreateWalks < ActiveRecord::Migration[6.0]
  def change
    create_table :walks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :starting_location
      t.string :ending_location
      t.references :stroll_setting, null: false, foreign_key: true
      t.integer :significance
      t.string :category
      t.integer :cost

      t.timestamps
    end
  end
end
