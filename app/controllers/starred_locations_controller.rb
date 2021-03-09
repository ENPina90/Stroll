class StarredLocationsController < ApplicationController

  def new
    @starred_location = StarredLocation.new
  end

  def create
    @starred_location = StarredLocation.new
    authorize @starred_location
    @starred_location.user = current_user
    @starred_location.location = Location.find(params[:starred_location][:location_id])
    @starred_location.save
    flash[:notice] = "Favorite added"
    redirect_to(locations_path)
  end

  def index
    @user = current_user
    @starred_locations = StarredLocation.where(user: current_user)
    skip_policy_scope
    authorize @starred_locations
  end

  def destroy
    @user = current_user
    @starred_location = StarredLocation.find(params[:id])
    @starred_location.destroy
    flash[:alert] = "Favorite removed"
    redirect_to(locations_path)
  end
end
