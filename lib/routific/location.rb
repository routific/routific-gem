module RoutificApi
  # This class represents a location in the network
  class Location
    attr_accessor :name, :lat, :lng

    # Constructor
    #
    # Required arguments in params:
    # lat: Latitude of this location
    # lng: Longitude of this location
    #
    # Optional arguments in params:
    # name: Name of this location
    def initialize(params)
      # Validates the parameters provided
      validate(params)

      @lat = params["lat"]
      @lng = params["lng"]
      @name = params["name"]
    end

    def ==(another_location)
      self.name == another_location.name &&
        self.lat == another_location.lat &&
        self.lng == another_location.lng
    end

    def to_json(options = nil)
      as_json(options).to_json
    end

    # Returns the JSON representation of this object
    # def to_json(options = nil)
    def as_json(options = nil)
      jsonData = {}
      jsonData["name"] = self.name if self.name
      jsonData["lat"] = self.lat
      jsonData["lng"] = self.lng

      jsonData
    end

    private
    # Validates the parameters being provided
    # Raises an ArgumentError if any of the required parameters is not provided.
    # Required parameters are: latitude and longitude
    def validate(params)
      if(params["lat"].nil? || params["lng"].nil?)
        raise ArgumentError, "'lat' and 'lng' parameters must be provided"
      end
    end
  end
end
