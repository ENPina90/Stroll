class StartingLocationsController < ApplicationController
  def index
    @starting_locations = policy_scope(StartingLocation)

    @markers = @starting_locations.geocoded.map do |starting_location|
      {
        lat: starting_location.latitude,
        lng: starting_location.longitude
      }
    end
  end
end
