class WalksController < ApplicationController
  before_action :set_walk, only: %i[show edit update destroy generate]

  def show
    authorize @walk
    @locations = generate
  end

  def generate
    total = 0
    points = []
    start = @walk.starting_location
    points.push(start)
    distance = 2.5
    nearby = Location.geocoded.near(start, distance, units: :km)
    oldloc = nearby.order("distance").last(5).sample
    newloc = start
    counter = 0
    while total < distance
      if newloc.latitude > oldloc.latitude
        cord = [oldloc.to_coordinates, newloc.to_coordinates]
      else
        cord = [newloc.to_coordinates, oldloc.to_coordinates]
      end
      enroute = Location.within_bounding_box(cord)
      puts "before .near"
      newloc = enroute.near(newloc).order("distance").reject { | loc | loc == newloc }.first(3).sample
      puts newloc.class == Location
      puts "after .near"
      newdist = points.last.distance_to(newloc)
      puts newdist
      # oldloc = points.last
      break if newloc.class != Location
      if newdist != 0 && !newloc.nil?
        total += newdist if counter > 0
        points.push(newloc)
      end
      puts total
      counter += 1
    end

    points.delete_at(1)
    newloc = points.last
    oldloc = @walk.starting_location
    counter = 0

    while total < distance * 2
      if newloc.latitude > oldloc.latitude
        cord = [oldloc.to_coordinates, newloc.to_coordinates]
      else
        cord = [newloc.to_coordinates, oldloc.to_coordinates]
      end
      enroute = Location.within_bounding_box(cord)
      puts "before .near"
      newloc = enroute.near(newloc).order("distance").reject { | loc | loc == newloc }.first(3).sample
      puts newloc
      puts "after .near"
      newdist = points.last.distance_to(newloc)
      puts newdist
      # oldloc = points.last
      break if newloc.class != Location
      if newdist != 0 && !newloc.nil?
        total += newdist if counter > 0
        points.push(newloc)
      end
      puts total
      counter += 1
    end
    # while total < distance * 2 do
    #   oldloc = points.last
    #   enroute = Location.within_bounding_box(oldloc.to_coordinates, start.to_coordinates)
    #   newloc = enroute.near(oldloc).order("distance").first(3).sample
    #   points.push(newloc)
    #   total += oldloc.distance_to(newloc)
    #   puts oldloc.distance_to(newloc)
    # en
    points.push(@walk.starting_location)
    points
  end

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
