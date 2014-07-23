# This class represents a location to visit in the route
class WayPoint
  attr_reader :location_id, :location_name, :arrival_time, :finish_time

  # Constructor
  def initialize(location_id, location_name, arrival_time, finish_time)
    @location_id = location_id
    @location_name = location_name
    @arrival_time = arrival_time
    @finish_time = finish_time
  end
end