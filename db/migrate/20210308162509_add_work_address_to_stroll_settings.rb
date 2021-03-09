class AddWorkAddressToStrollSettings < ActiveRecord::Migration[6.0]
  def change
    add_column :stroll_settings, :work_address, :string
  end
end
