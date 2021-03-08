class StartingLocationsController < ApplicationController
  def new
    @starting_location = StartingLocation.new
    @walk = Walk.find(params[:walk_id])
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
