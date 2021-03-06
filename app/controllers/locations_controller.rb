class LocationsController < ApplicationController
  def index
    @locations = policy_scope(Location)
    @starred_location = StarredLocation.new
    @starred_locations = StarredLocation.where(user: current_user).map(&:location_id)
    # @location = Location.find(params[:id])
    # @this_starred_location = StarredLocation.where(location_id: @location.id, user_id: current_user.id).first
    @markers = @locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { location: location }),
        image_url: @starred_locations.include?(location.id) ? helpers.asset_url('star2.jpg') : helpers.asset_url('right_color.png')
      }
    end
  end

  def show
    @location = Location.find(params[:id])
    authorize @location
    @this_starred_location = StarredLocation.where(location_id: @location.id, user_id: current_user.id).first
    @starred_location = StarredLocation.new
    @starred_locations = StarredLocation.where(user: current_user).map(&:location_id)
    @notes = Note.where(location_id: params[:id])
    @note = Note.new
  end
end
