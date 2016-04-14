module RoutificApi
  # This class represents a location to visit in the route
  class WayPoint
    attr_reader :location_id, :arrival_time, :finish_time, :location_name

    # Constructor
    def initialize(options = {})
      @location_id = options['location_id']
      @arrival_time = options['arrival_time']
      @finish_time = options['finish_time']
      @location_name = options['location_name']
    end
  end
end
