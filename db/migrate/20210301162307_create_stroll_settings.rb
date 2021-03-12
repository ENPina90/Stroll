class CreateStrollSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :stroll_settings do |t|
      t.string :category
      t.integer :significance, default: 3
      t.boolean :cost, default: true
      t.boolean :newness, default: false
      t.boolean :attractions, default: true
      t.boolean :architecture, default: true
      t.boolean :bar, default: true
      t.boolean :cafe, default: true
      t.boolean :culture, default: true
      t.boolean :gallery, default: true
      t.boolean :hidden_places, default: true
      t.boolean :history, default: true
      t.boolean :memorial, default: true
      t.boolean :museum, default: true
      t.boolean :nieghborhood, default: true
      t.boolean :park, default: true
      t.boolean :restaurant, default: true
      t.boolean :shop, default: true
      t.boolean :sculpture, default: true
      t.boolean :street_art, default: true
      t.boolean :view, default: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

