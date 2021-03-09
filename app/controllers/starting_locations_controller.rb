class StartingLocationsController < ApplicationController
  def new
    @starting_location = StartingLocation.new
    @walk = Walk.create(stroll_setting: current_user.stroll_setting, user: current_user)
    authorize @starting_location
  end

  def create
    @walk = Walk.find(params[:walk_id])
    @starting_location = StartingLocation.new(address: params[:address], duration: params[:duration])
    @starting_location.walk = @walk
    authorize @starting_location
    if @starting_location.save
      @starting_location = @walk.starting_location
      redirect_to walk_path(@walk)
    else
      render :new
    end
  end
end
