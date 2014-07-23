Routific Ruby Gem
=================

This Ruby Gem assists users to easily access the [Routific API][1], which is a practical and scalable solution to the Vehicle Routing Problem.

Logistics companies struggle with this challenge every day; most of them are still manually scheduling their fleet with a team of dispatchers.

Routific can automate this process, and optimize it. The savings are tremendous: less fuel, and fewer vehicles, drivers and dispatchers.

In the U.S., 1/8th of all fuel is consumed by trucks - that's 50 billion gallons a year. Our optimization algorithms will reduce that number by 20%!

  [1]: https://routific.com

Installing
----------

> gem install routific

Usage
-----
Remember to require it before using it

> require 'routific'

The following instance methods are available:

 - Sets a location with the specified ID and parameters
    Required arguments in params:
  
     - lat: Latitude of this location
     - lng: Longitude of this location

    Optional arguments in params:
     - name: Name of this location

   > routific.setLocation( id, params )

 - Sets a visit for the specified location using the specified parameters
    Optional arguments in params:
     - start: the earliest time for this visit. Default value is 00:00, if not specified. 
     - end: the latest time for this visit. Default value is    23:59, if not specified.
     - duration: the length of this visit in minutes
     - demand: the capacity that this visit requires

   > routific.setVisit( id, [params] )

 - Sets a vehicle with the specified ID and parameters
    Required arguments in params:
     - start_location: ID of start location for this vehicle

    Optional arguments in params:
     - end_location: ID of end location for this vehicle
     - shift_start: this vehicle's start shift time (e.g. '08:00'). Default value is 00:00, if not specified.
     - shift_end: this vehicle's end shift time (e.g. '17:00'). Default value is 23:59, if not specified.
     - capacity: the capacity that this vehicle can load

   > routific.setVehicle( id, params )

 - Returns the route using the previously provided network, visits and
   fleet information
   > routific.getRoute()

The following class methods are available:

 - Sets the default access token to use
   > Routific.setToken( token )

 - Returns the route using the specified access token, network, visits and fleet information
   > Routific.getRoute( id, [params] )

Both getRoute functions return the Route object, which has the following methods:

 - status: A sanity check, will always be success when the HTTP code is 200
 - fitness: Total travel-time, representing the fitness score of the solution (less is better)
 - unserved: List of visits that could not be scheduled. 
 - vehicleRoutes: The optimized schedule

Examples
--------
Example 1:

    require 'routific'
    
    routific = Routific.new(--API_KEY--)
    routific.setLocation("order_1", {
      "name" => "6800 Cambie",
      "lat" => 49.227107,
      "lng" => -123.1163085,
    })
    
    routific.setLocation("depot", {
      "name" => "800 Kingsway",
      "lat" => 49.2553636,
      "lng" => -123.0873365,
    })
    
    routific.setVisit("order_1", {
      "start" => "9:00",
      "end" => "12:00",
      "duration" => 10,
    })
    
    routific.setVehicle("vehicle_1", {
      "start_location" => "depot",
      "end_location" => "depot",
      "shift_start" => "8:00",
      "shift_end" => "12:00",
    })
    
Example 2:

    require 'routific'
    
    Routific.setToken(--API_KEY--)
    network = {
        "order_1" => {
          "name" => "6800 Cambie",
          "lat" => 49.227107,
          "lng" => -123.1163085
        },
        "depot" => {
          "name" => "800 Kingsway",
          "lat" => 49.2553636,
          "lng" => -123.0873365
        }
    }
    visits = {
        "order_1" => {
          "start" => "9:00",
          "end" => "12:00",
          "duration" => 10
        }
    }
    fleet = {
        "vehicle_1" => {
          "start-location" => "depot",
          "end-location" => "depot",
          "shift-start" => "8:00",
          "shift-end" => "12:00"
        }
    }
    @data = {
        network: network,
        visits: visits,
        fleet: fleet
    }
    Routific.getRoute(@data)