class AddCoordinatesToStartingLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :starting_locations, :latitude, :float
    add_column :starting_locations, :longitude, :float
  end
end
