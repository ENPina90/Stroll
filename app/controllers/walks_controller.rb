require 'json'
require 'open-uri'

class WalksController < ApplicationController
  # before_action :set_walk, only: [:show, :edit, :update, :destroy]
  def show
    authorize @walk
    url = "https://api.mapbox.com/directions/v5/mapbox/walking/#{@walk.starting_location.latitude}%2C#{@walk.starting_location.longitude}%3B#{@walk.ending_location.latitude}%2C#{@walk.ending_location.longitude}?alternatives=false&geometries=geojson&steps=true&access_token=#{ENV['MAPBOX_API_KEY']}"
    route_serialized = open(url).read
    route = JSON.parse(route_serialized)
  end

  # private

  # def set_walk
  #   @walk = Walk.find
  # end
end
