require_relative './break'

module RoutificApi
  # This class represents a vehicle in the fleet
  class Vehicle
    attr_accessor :id, :start_location, :end_location, :shift_start,
      :shift_end, :capacity, :strict_start, :min_visits, :speed, :breaks, :type

    # Constructor
    #
    # Required arguments in params:
    # start_location: start location for this vehicle. Instance of Location
    #
    # Optional arguments in params:
    # end_location: end location for this vehicle. Instance of Location
    # shift_start: this vehicle's start shift time (e.g. '08:00'). Default value is 00:00, if not specified.
    # shift_end: this vehicle's end shift time (e.g. '17:00'). Default value is 23:59, if not specified.
    # capacity: the capacity that this vehicle can load
    def initialize(id, params)
      validate(params)

      @id = id
      @start_location = RoutificApi::Location.new(params["start_location"])
      if params["end_location"]
        @end_location = RoutificApi::Location.new(params["end_location"])
      end
      @shift_start = params["shift_start"]
      @shift_end = params["shift_end"]
      @capacity = params["capacity"]
      @strict_start = params["strict_start"]
      @min_visits = params["min_visits"]
      @speed = params["speed"]
      @type = params["type"]
      if params["breaks"]
        @breaks = params["breaks"].map{ |brk| RoutificApi::Break.new(brk) }
      end
    end

    def to_json(options=nil)
      as_json(options).to_json
    end

    # Returns the JSON representation of this object
    # def to_json(options = nil)
    def as_json(options = nil)
      json_data = {}
      json_data["start_location"] = self.start_location.as_json
      json_data["end_location"] = self.end_location.as_json if self.end_location
      json_data["shift_start"] = self.shift_start if self.shift_start
      json_data["shift_end"] = self.shift_end if self.shift_end
      json_data["capacity"] = self.capacity if self.capacity
      json_data["strict_start"] = self.strict_start if not self.strict_start.nil?
      json_data["min_visits"] = self.min_visits if self.min_visits
      json_data["speed"] = self.speed if self.speed
      json_data["type"] = self.type if self.type
      if self.breaks
        json_data["breaks"] = self.breaks.map{ |brk| brk.as_json }
      end

      json_data
    end


    private
    # Validates the parameters being provided
    # Raises an ArgumentError if any of the required parameters is not provided.
    # Required parameters are: location
    def validate(params)
      if params["start_location"].nil?
        raise ArgumentError, "'start-location' parameter must be provided"
      end
    end
  end
end
