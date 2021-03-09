class StarredLocationsController < ApplicationController
  def index
    @user = current_user
    @starred_locations = StarredLocation.where(user: current_user)
    skip_policy_scope
    authorize @starred_locations

    @markers = @starred_locations.map do |starred_location|
      {
        lat: Location.find(starred_location.location_id).latitude,
        lng: Location.find(starred_location.location_id).longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { starred_location: starred_location }),
        image_url: helpers.asset_url('star2.jpg')
      }
    end
  end

  def new
    @starred_location = StarredLocation.new
  end

  def create
    @starred_location = StarredLocation.new
    authorize @starred_location
    @starred_location.user = current_user
    @starred_location.location = Location.find(params[:starred_location][:location_id])
    if @starred_location.save
      flash[:notice] = "Location saved"
      redirect_to(locations_path)
    else
      flash[:alert] = "Location not saved"
      redirect_to(locations_path)
    end
  end
end
