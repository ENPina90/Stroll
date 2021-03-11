class CreateStrollSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :stroll_settings do |t|
      t.string :category
      t.integer :significance, default: 3
      t.boolean :cost, default: true
      t.boolean :newness, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
