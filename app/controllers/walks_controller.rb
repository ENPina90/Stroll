class WalksController < ApplicationController
  before_action :set_walk, only: %i[show edit update destroy generate]

  def show
    authorize @walk
    if @walk.stroll_locations.empty?
      @locations = generate
      @locations.each do |location|
        StrollLocation.create(location: location, walk: @walk) unless location.class == StartingLocation
      end
    else
      @locations = [@walk.starting_location] + @walk.locations + [@walk.starting_location]
    end
  end

  def filter(locations)
    significances = []
    possible = []
    if current_user.stroll_setting.significance >= 1
      locations.each { |location| significances.push(location) if location.significance == 1 }
    end
    if current_user.stroll_setting.significance >= 2
      locations.each { |location| significances.push(location) if location.significance == 2 }
    end
    if current_user.stroll_setting.significance >= 3
      locations.each { |location| significances.push(location) if location.significance == 3 }
    end
    if current_user.stroll_setting.attractions
      significances.each { |location| possible.push(location) if location.category == "Attractions" }
    end
    if current_user.stroll_setting.history
      significances.each { |location| possible.push(location) if location.category == "History" }
    end
    if current_user.stroll_setting.street_art
      significances.each { |location| possible.push(location) if location.category == "Street Art" }
    end
    if current_user.stroll_setting.architecture
      significances.each { |location| possible.push(location) if location.category == "Architecture" }
    end
    if current_user.stroll_setting.cafe
      significances.each { |location| possible.push(location) if location.category == "Cafe" }
    end
    if current_user.stroll_setting.bar
      significances.each { |location| possible.push(location) if location.category == "Bars" }
    end
    if current_user.stroll_setting.restaurant
      significances.each { |location| possible.push(location) if location.category == "Restaurant" }
    end
    if current_user.stroll_setting.shop
      significances.each { |location| possible.push(location) if location.category == "Shop" }
    end
    if current_user.stroll_setting.museum
      significances.each { |location| possible.push(location) if location.category == "Museum" }
    end
    if current_user.stroll_setting.gallery
      significances.each { |location| possible.push(location) if location.category == "Gallery" }
    end
    if current_user.stroll_setting.memorial
      significances.each { |location| possible.push(location) if location.category == "Memorial" }
    end
    if current_user.stroll_setting.nieghborhood
      significances.each { |location| possible.push(location) if location.category == "Nieghborhood" }
    end
    if current_user.stroll_setting.hidden_places
      significances.each { |location| possible.push(location) if location.category == "Hidden Places" }
    end
    if current_user.stroll_setting.park
      significances.each { |location| possible.push(location) if location.category == "Park" }
    end
    if current_user.stroll_setting.culture
      significances.each { |location| possible.push(location) if location.category == "Culture" }
    end
    if current_user.stroll_setting.cost
      filtered = possible.reject { |location| location.cost == 1 }
    end
    filtered
  end

  def generate
    min = @walk.starting_location.duration
    distance = min / 30.to_f
    total = 0
    points = []
    start = @walk.starting_location
    points.push(start)
    nearby = Location.geocoded.near(start, distance, units: :km)
    oldloc = nearby.order("distance").last(10).sample
    newloc = start
    counter = 0
    while total < distance
      # tic = counter == 0 ? 5 : 2
      if newloc.latitude > oldloc.latitude
        cord = [oldloc.to_coordinates, newloc.to_coordinates]
      else
        cord = [newloc.to_coordinates, oldloc.to_coordinates]
      end
      enroute = Location.within_bounding_box(cord)
      puts "before .near"
      newloc = filter(enroute.near(newloc).order("distance").reject { | loc | loc.to_coordinates == newloc.to_coordinates }).first(3).sample
      puts newloc.class == Location
      puts "after .near"
      newdist = points.last.distance_to(newloc)
      puts newdist
      # oldloc = points.last
      break if newloc.class != Location || newdist == 0.0
      if newdist != 0 && !newloc.nil?
        total += newdist if counter > 0
        points.push(newloc)
      end
      puts total
      counter += 1
      # if newdist <= 0.0
      #   raise
      # end
    end

    points.delete_at(1)
    newloc = points.last
    oldloc = @walk.starting_location
    counter = 0

    while total < distance * 2.75
      # tic = counter == 0 ? 5 : 2
      if newloc.latitude > oldloc.latitude
        cord = [oldloc.to_coordinates, newloc.to_coordinates]
      else
        cord = [newloc.to_coordinates, oldloc.to_coordinates]
      end
      enroute = Location.within_bounding_box(cord)
      puts "before .near"
      newloc = filter(enroute.near(newloc).order("distance").reject { | loc | loc == newloc }).first(3).sample
      puts newloc
      puts "after .near"
      newdist = points.last.distance_to(newloc)
      puts newdist
      # oldloc = points.last
      break if newloc.class != Location || newdist == 0.0
      if newdist != 0 && !newloc.nil?
        total += newdist if counter > 0
        points.push(newloc)
      end
      puts total
      counter += 1
      if newdist <= 0.0
        raise
      end
    end
    # while total < distance * 2 do
    #   oldloc = points.last
    #   enroute = Location.within_bounding_box(oldloc.to_coordinates, start.to_coordinates)
    #   newloc = enroute.near(oldloc).order("distance").first(3).sample
    #   points.push(newloc)
    #   total += oldloc.distance_to(newloc)
    #   puts oldloc.distance_to(newloc)
    # en
    ## is it neccassary to push the starting location at the end
    points.push(@walk.starting_location)
    points
  end


  def near
    StartingLocation.last.near
  end

  def index
    @walks = policy_scope(Walk).order(created_at: :desc)
  end

  private

  def walk_params
    params.require(:walk).permit(:stroll_setting_id)
  end

  def set_walk
    @walk = Walk.where(user: current_user).find(params[:id])
  end
end
