require 'rest-client'
require 'json'

require_relative './routific/location'
require_relative './routific/visit'
require_relative './routific/vehicle'
require_relative './routific/route'
require_relative './routific/way_point'
require_relative './routific/options'

# Main class of this gem
class Routific
  attr_reader :token, :visits, :fleet, :options
  BASE_URL = 'https://api.routific.com/v1/'

  # Constructor
  # token: Access token for Routific API
  def initialize(token)
    @token = token
    @visits = {}
    @fleet = {}
    @options = {}
  end

  # Sets a visit for the specified location using the specified parameters
  # id: ID of location to visit
  # params: parameters for this visit
  def setVisit(id, params={})
    visits[id] = RoutificApi::Visit.new(id, params)
  end

  # Sets a vehicle with the specified ID and parameters
  # id: vehicle ID
  # params: parameters for this vehicle
  def setVehicle(id, params)
    fleet[id] = RoutificApi::Vehicle.new(id, params)
  end

  # Sets options with the specified params
  # params: parameters for these options
  def setOptions(params)
    @options = RoutificApi::Options.new(params)
  end

  # Returns the route using the previously provided visits and fleet information
  def getRoute
    data = {
      visits: visits,
      fleet: fleet
    }

    data[:options] = options if options
    Routific.getRoute(data, token)
  end

  def get_route_async
    data = {
      visits: visits,
      fleet: fleet
    }

    data[:options] = options if options
    Routific.get_route_async(data, token)
  end

  def update_job(job_id, token = @@token)
    send_request("GET", "jobs/#{job_id}", token)
  end

  class << self
    # Sets the default access token to use
    def setToken(token)
      @@token = token
    end

    def token
      @@token
    end

    # Returns the route using the specified access token, visits and fleet information
    # If no access token is provided, the default access token previously set is used
    # If the default access token either is nil or has not been set, an ArgumentError is raised
    def getRoute(data, token = @@token)
      result = send_request("POST", "vrp", token, data)
      RoutificApi::Route.parse(jsonResponse)
    end

    def get_route_async(data, token = @@token)
      result = send_request("POST", "vrp-long", token, data)
      RoutificApi::Job.new(result["job_id"], data, self)
    end

    private
    def validate_and_prefix_token(token)
      if token.nil?
        raise ArgumentError, "access token must be set"
      end

      # Prefix the token with "bearer " if missing during assignment
      (/bearer /.match(token).nil?) ? "bearer #{token}" : token
    end

    ##
    # method: "GET", "POST"
    # endpoint: "vrp", "vrp-long", "job"
    # token: if nil, raise ArgumentError; if missing "bearer", prefix
    # data: only for POST requests
    #
    def send_request(method, endpoint, token, data = nil)
      url = BASE_URL + endpoint
      headers = {
        'Authorization' => validate_and_prefix_token(token),
        content_type: :json,
        accept: :json
      }
      begin
        # Sends HTTP request to Routific API server
        response = nil
        if method == 'GET'
          response = RestClient.get(url, headers)
        elsif method == 'POST'
          response = RestClient.post(url, data.to_json, headers)
        end

        return JSON.parse(response)
      rescue => e
        puts e
        errorResponse = JSON.parse e.response.body
        puts "Received HTTP #{e.message}: #{errorResponse["error"]}"
        nil
      end
    end
  end
end
