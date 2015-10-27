module RoutificApi
  # This class represents a location to visit in the route
  class WayPoint
    attr_reader :location_id, :arrival_time, :finish_time

    # Constructor
    def initialize(location_id, arrival_time, finish_time)
      @location_id = location_id
      @arrival_time = arrival_time
      @finish_time = finish_time
    end
  end
end
