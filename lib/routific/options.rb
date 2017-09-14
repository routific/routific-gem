module RoutificApi
  # This class represents a set of options for the request
  class Options
    VALID_PARAMS = %w{ traffic min_visits_per_vehicle balance min_vehicles shortest_distance squash_durations max_vehicle_overtime max_visit_lateness }

    attr_reader *VALID_PARAMS

    def initialize(params)
      # Validates the provided parameters
      validate(params)
      
      VALID_PARAMS.each do |param|
        instance_variable_set "@#{param}", params[param]
      end
    end

    def to_json(options)
      as_json(options).to_json
    end

    # Returns the JSON representation of this object
    # def to_json(options = nil)
    def as_json(options = nil)
      jsonData = {}
      
      VALID_PARAMS.each do |param|
        instance_var = instance_variable_get "@#{param}"
        jsonData[param] = instance_var if instance_var
      end
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
