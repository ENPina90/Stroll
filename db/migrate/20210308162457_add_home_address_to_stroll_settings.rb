class AddHomeAddressToStrollSettings < ActiveRecord::Migration[6.0]
  def change
    add_column :stroll_settings, :home_address, :string
  end
end
