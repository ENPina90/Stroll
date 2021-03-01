class CreateStrollSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :stroll_settings do |t|
      t.string :type
      t.integer :significance
      t.integer :cost
      t.boolean :newnes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
