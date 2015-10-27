module RoutificApi
  # This class represents the resulting route returned by the Routific API
  class Route
    attr_reader :status, :fitness, :unserved, :vehicleRoutes

    # Constructor
    def initialize(status, fitness, unserved)
      @status = status
      @fitness = fitness
      @unserved = unserved
      @vehicleRoutes = Hash.new()
    end

    # Adds a new way point for the specified vehicle
    def addWayPoint(vehicle_name, way_point)
      if @vehicleRoutes[vehicle_name].nil?
        # No previous way point was added for the specified vehicle, so create a new array
        @vehicleRoutes[vehicle_name] = []
      end
      # Adds the provided way point for the specified vehicle
      @vehicleRoutes[vehicle_name] << way_point
    end

    class << self
      # Parse the JSON representation of a route, and return it as a Route object
      def parse(routeJson)
        status = routeJson["status"]
        fitness = routeJson["fitness"]
        unserved = routeJson["unserved"]
        route = RoutificApi::Route.new(status, fitness, unserved)

        # Get way points for each vehicles
        routeJson["solution"].each do |vehicle_name, way_points|
          # Get all way points for this vehicle
          way_points.each do |waypoint_info|
            # Get all information for this way point
            location_id = waypoint_info["location_id"]
            arrival_time = waypoint_info["arrival_time"]
            finish_time = waypoint_info["finish_time"]
            way_point = RoutificApi::WayPoint.new(location_id, arrival_time, finish_time)
            route.addWayPoint(vehicle_name, way_point)
          end
        end

        # Return the resulting Route object
        route
      end
    end
  end
end
