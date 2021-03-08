require 'pry'

class WalksController < ApplicationController
  before_action :set_walk, only: %i[show edit update destroy]

  def show
    authorize @walk
    @locations = generate
  end

  def generate
    total = 0
    points = []
  # choose farthest location:
    start = StartingLocation.first
    points.push(start)
    # distance chosen by user, divided by 2(because of round trip and other locations)!
    distance = 5
    nearby = Location.near(start, distance, units: :km)
    farthest = nearby.order("distance").last
  # choose loc1
    # enroute = Location.within_bounding_box(farthest.to_coordinates, start.to_coordinates)
    # loc = enroute.near(start).order("distance").first(5).sample
    # locations.push(loc)
    # total += start.distance_to(loc)
  # choose loc#
    while total < distance do
      oldloc = points.last
      enroute = Location.within_bounding_box(farthest.to_coordinates, oldloc.to_coordinates)
      newloc = enroute.near(oldloc).order("distance").first(5).sample
      points.push(newloc)
      total += oldloc.distance_to(newloc)
      puts total
    end

    total.to_i
    while total < distance*2 do
      oldloc = points.last
      enroute = Location.within_bounding_box(oldloc.to_coordinates, start.to_coordinates)
      newloc = enroute.near(oldloc).order("distance").first(5).sample
      points.push(newloc)
      total += oldloc.distance_to(newloc)
      puts oldloc.distance_to(newloc)
    end

    points
  end


    # if total.to_i < distance
    #   # counter =+ 1
    #   enroute = Location.within_bounding_box(farthest.to_coordinates, loc1.to_coordinates)
    # else
    #   enroute = Location.within_bounding_box(start.to_coordinates, loc2.to_coordinates)
    # end
    # loc2 = enroute.near(loc1).order("distance").first(5).sample

    # if total.to_i < distance
    #   enroute = Location.within_bounding_box(farthest.to_coordinates, loc2.to_coordinates)
    # else
    #   enroute = Location.within_bounding_box(start.to_coordinates, loc2.to_coordinates)
    # end
    # loc3 = enroute.near(loc2).order("distance").first(5).sample

    # if total.to_i < distance
    #   enroute = Location.within_bounding_box(farthest.to_coordinates, loc3.to_coordinates)
    # else
    #   enroute = Location.within_bounding_box(start.to_coordinates, loc3.to_coordinates)
    # end
    # loc4 = enroute.near(loc3).order("distance").first(5).sample

    #   #
    # enroute = Location.within_bounding_box(farthest.to_coordinates, loc1.to_coordinates)
    # loc2 = enroute.near(loc1).order("distance").first(5).sample
    # total =+ loc1.distance_to(loc2)
  # repeat x times?
    # loc3 = farthest
  # reverse
    # enroute = Location.within_bounding_box(farthest.to_coordinates, start.to_coordinates)
    #loc4 = enroute.near(loc3).order("distance").first(5).sample
  # repeat x times?
    #ending location = start




  # s = StartingLocation.first
  # nearby = Location.near(cord, 0.5)
  # cord = [s.latitude, s.longitude]

  # geocoder method.near
 # repeat with 2,3,4...
 # method.distance
 # choose the one with smalles distance to the ending location

  def near
    StartingLocation.last.near
  end


  private

  def walk_params
    params.require(:walk).permit(:stroll_setting_id)
  end

  def set_walk
    @walk = current_user.walks.last
  end
end
