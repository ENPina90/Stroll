class AddDurationToStartingLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :starting_locations, :duration, :integer
  end
end
