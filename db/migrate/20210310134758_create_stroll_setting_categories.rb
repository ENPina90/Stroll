class CreateStrollSettingCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :stroll_setting_categories do |t|
      t.references :category, null: false, foreign_key: true
      t.references :stroll_setting, null: false, foreign_key: true
      t.timestamps
    end
  end
end
