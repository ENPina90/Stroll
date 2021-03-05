class LocationsController < ApplicationController
  def index
    @locations = policy_scope(Location)

    @markers = @locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { location: location }),
        image_url: helpers.asset_url('right_color.png')
      }
    end
  end
end
