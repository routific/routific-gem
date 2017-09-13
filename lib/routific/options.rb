module RoutificApi
  # This class represents a set of options for the request
  class Options
    VALID_PARAMS = %w{ traffic min_visits_per_vehicle balance min_vehicles shortest_distance squash_durations max_vehicle_overtime max_visit_lateness }

    attr_reader *VALID_PARAMS

    def initialize(params)
      # Validates the provided parameters
      validate(params)

      @traffic = params["traffic"]
      @min_visits_per_vehicle = params["min_visits_per_vehicle"]
      @balance = params["balance"]
      @min_vehicles = params["min_vehicles"]
      @shortest_distance = params["shortest_distance"]
      @squash_durations = params["squash_durations"]
      @max_visit_lateness = params["max_visit_lateness"]
      @max_vehicle_overtime = params["max_vehicle_overtime"]
    end

    def to_json(options)
      as_json(options).to_json
    end

    # Returns the JSON representation of this object
    # def to_json(options = nil)
    def as_json(options = nil)
      jsonData = {}
      jsonData["traffic"] = self.traffic if self.traffic
      jsonData["min_visits_per_vehicle"] = self.min_visits_per_vehicle if self.min_visits_per_vehicle
      jsonData["balance"] = self.balance if self.balance
      jsonData["shortest_distance"] = self.shortest_distance if self.shortest_distance
      jsonData["min_vehicles"] = self.min_vehicles if self.min_vehicles

      jsonData
    end

    private
    # Validates the parameters being provided
    # Raises an ArgumentError if any of the provided params is not supported
    def validate(params)
      invalid = params.keys.reject { |k| VALID_PARAMS.include?(k) }

      if invalid.any?
        invalid = invalid.join(",")
        raise ArgumentError, "#{invalid} parameter is not supported"
      end
    end
  end
end
