class AddCoordinatesToEndingLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :ending_locations, :latitude, :float
    add_column :ending_locations, :longitude, :float
  end
end
