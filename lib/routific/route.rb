module RoutificApi
  # This class represents the resulting route returned by the Routific API
  class Route
    FIELDS = [
      :status,
      :unserved, :num_unserved,
      :distances, :total_distance,
      :total_working_time, :total_travel_time,
      :total_break_time, :total_idle_time,
      :total_visit_lateness, :num_late_visits,
      :vehicle_overtime, :total_vehicle_overtime,
      :polylines,
    ]

    attr_reader *FIELDS
    attr_reader :vehicle_routes

    # Constructor
    def initialize(data)
      FIELDS.each do |field|
        instance_variable_set "@#{field}", data[field]
      end
      add_solution(data[:solution] || {})
    end

    def add_solution(solution)
      @vehicle_routes = {}

      solution.each do |vehicle_name, way_points|
        # Get all way points for this vehicle
        way_points.each do |waypoint_info|
          # Get all information for this way point
          way_point = RoutificApi::WayPoint.new(waypoint_info)
          add_way_point(vehicle_name, way_point)
        end
      end
    end

    # Adds a new way point for the specified vehicle
    def add_way_point(vehicle_name, way_point)
      if @vehicle_routes[vehicle_name].nil?
        # No previous way point was added for the specified vehicle, so create a new array
        @vehicle_routes[vehicle_name] = []
      end
      # Adds the provided way point for the specified vehicle
      @vehicle_routes[vehicle_name] << way_point
    end

    class << self
      # Parse the JSON representation of a route, and return it as a Route object
      def parse(data)
        data = process_data(data)
        RoutificApi::Route.new(data)
      end

      def process_data(hash)
        hash.keys.each do |key|
          hash[(key.to_sym rescue key) || key] = hash.delete(key)
        end
        hash
      end
    end
  end
end
