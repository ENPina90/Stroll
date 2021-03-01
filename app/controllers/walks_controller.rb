class WalksController < ApplicationController
  def index
    @walks = Walk.geocoded

    @markers = @walks.map do |walk|
      {
        lat: walk.latitude,
        lng: walk.longitude,
        infoWindow: render_to_string(partial: "infowindow", locals: { walk: walk }),
        image_url: helpers.asset_url('REPLACE_THIS_WITH_YOUR_IMAGE_IN_ASSETS')
      }
    end
  end
end
