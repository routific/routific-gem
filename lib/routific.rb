require 'rest-client'
require 'json'

require_relative './routific/location'
require_relative './routific/visit'
require_relative './routific/vehicle'
require_relative './routific/route'
require_relative './routific/way_point'

# Main class of this gem
class Routific
  attr_reader :token, :network, :visits, :fleet

  # Constructor
  # token: Access token for Routific API
  def initialize(token)
    @token = token
    @network = {}
    @visits = {}
    @fleet = {}
  end

  # Sets a location with the specified ID and parameters
  # id: location ID
  # params: parameters for this location
  def setLocation(id, params)
    network[id] = Location.new(params)
  end

  # Sets a visit for the specified location using the specified parameters
  # id: ID of location to visit
  # params: parameters for this visit
  def setVisit(id, params={})
    visits[id] = Visit.new(params)
  end

  # Sets a vehicle with the specified ID and parameters
  # id: vehicle ID
  # params: parameters for this vehicle
  def setVehicle(id, params)
    fleet[id] = Vehicle.new(params)
  end

  # Returns the route using the previously provided network, visits and fleet information
  def getRoute
    data = {
      network: network,
      visits: visits,
      fleet: fleet
    }

    Routific.getRoute(data, token)
  end

  class << self
    # Sets the default access token to use
    def setToken(token)
      @@token = (/bearer /.match(token).nil?) ? "bearer #{@@token}" : token
    end

    def token
      return @@token
    end

    # Returns the route using the specified access token, network, visits and fleet information
    # If no access token is provided, the default access token previously set is used
    # If the default access token either is nil or has not been set, an ArgumentError is raised
    def getRoute(data, token = @@token)
      if token.nil?
        raise ArgumentError, "access token must be set"
      end

      # Sends HTTP request to Routific API server
      response = RestClient.post('https://routific.com/api/vrp', 
        data.to_json,
        'Authorization' => token,
        content_type: :json,
        accept: :json
        )

      # Parse the HTTP request response to JSON
      jsonResponse = JSON.parse(response)

      # Parse the JSON representation into a Route object
      Route.parse(jsonResponse)
    end
  end
end