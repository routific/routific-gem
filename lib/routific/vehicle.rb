# This class represents a vehicle in the fleet
class Vehicle
  attr_accessor :start_location, :end_location, :shift_start, :shift_end, :capacity

  # Constructor
  #
  # Required arguments in params:
  # start_location: ID of start location for this vehicle
  #
  # Optional arguments in params:
  # end_location: ID of end location for this vehicle
  # shift_start: this vehicle's start shift time (e.g. '08:00'). Default value is 00:00, if not specified.
  # shift_end: this vehicle's end shift time (e.g. '17:00'). Default value is 23:59, if not specified.
  # capacity: the capacity that this vehicle can load
  def initialize(params)
    # Validates the provided parameters
    validate(params)

    @start_location = params["start_location"]
    @end_location = params["end_location"]
    @shift_start = params["shift_start"]
    @shift_end = params["shift_end"]
    @capacity = params["capacity"]
  end

  def to_json(options=nil)
    as_json(options).to_json
  end

  # Returns the JSON representation of this object
  # def to_json(options = nil)
  def as_json(options = nil)
    jsonData = {}
    jsonData["start-location"] = self.start_location
    jsonData["end-location"] = self.end_location if self.end_location
    jsonData["shift-start"] = self.shift_start if self.shift_start
    jsonData["shift-end"] = self.shift_end if self.shift_end
    jsonData["capacity"] = self.capacity if self.capacity

    jsonData
  end

  private
  # Validates the parameters being provided
  # Raises an ArgumentError if any of the required parameters is not provided.
  # Required parameter is: start_location
  def validate(params)
    if(params["start_location"].nil?)
      raise ArgumentError, "'start_location' parameter must be provided"
    end
  end
end