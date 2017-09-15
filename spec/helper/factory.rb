class Factory
  # LOCATION_1_ID = Faker::Lorem.word
  # LOCATION_2_ID = Faker::Lorem.word
  # LOCATION_3_ID = Faker::Lorem.word

  # # Factory and constants for location
  LOCATION_NAME = Faker::Lorem.word
  LOCATION_LATITUDE = Faker::Address.latitude.to_f
  LOCATION_LONGITUDE = Faker::Address.longitude.to_f
  LOCATION_PARAMS = {
    "name"  => LOCATION_NAME,
    "lat"   => LOCATION_LATITUDE,
    "lng"   => LOCATION_LONGITUDE
    }
  LOCATION = RoutificApi::Location.new(LOCATION_PARAMS)

  # Factory and constants for visit
  VISIT_ID = Faker::Lorem.word
  VISIT_START = "08:00"
  VISIT_END = "22:00"
  VISIT_DURATION = Faker::Number.digit
  VISIT_DEMAND = Faker::Number.digit
  VISIT_LOCATION = {
    "lat" => Faker::Address.latitude.to_f,
    "lng" => Faker::Address.longitude.to_f,
  }
  VISIT_PARAMS = {
    "start"     => VISIT_START,
    "end"       => VISIT_END,
    "duration"  => VISIT_DURATION,
    "demand"    => VISIT_DEMAND,
    "location"  => VISIT_LOCATION
  }
  VISIT = RoutificApi::Visit.new(VISIT_ID, VISIT_PARAMS)

  # Factory and constants for vehicle
  VEHICLE_ID = Faker::Lorem.word
  VEHICLE_NAME = Faker::Lorem.word
  VEHICLE_START_LOCATION = {
    "lat" => Faker::Address.latitude.to_f,
    "lng" => Faker::Address.longitude.to_f,
  }
  VEHICLE_END_LOCATION = {
    "lat" => Faker::Address.latitude.to_f,
    "lng" => Faker::Address.longitude.to_f,
  }
  VEHICLE_SHIFT_START = "06:00"
  VEHICLE_SHIFT_END = "18:00"
  VEHICLE_CAPACITY = Faker::Number.digit
  VEHICLE_PARAMS = {
    "start_location"  => VEHICLE_START_LOCATION,
    "end_location"    => VEHICLE_END_LOCATION,
    "shift_start"     => VEHICLE_SHIFT_START,
    "shift_end"       => VEHICLE_SHIFT_END,
    "capacity"        => VEHICLE_CAPACITY
    }
  VEHICLE = RoutificApi::Vehicle.new(VEHICLE_ID, VEHICLE_PARAMS)

  # Factory and constants for way point
  WAY_POINT_LOCATION_ID = Faker::Lorem.word
  WAY_POINT_ARRIVAL_TIME = "09:00"
  WAY_POINT_FINISH_TIME = "09:10"
  WAY_POINT_LOCATION_NAME = Faker::Lorem.word
  WAY_POINT = RoutificApi::WayPoint.new({
    'location_id'   => WAY_POINT_LOCATION_ID,
    'arrival_time'  => WAY_POINT_ARRIVAL_TIME,
    'finish_time'   => WAY_POINT_FINISH_TIME,
    'location_name' => WAY_POINT_LOCATION_NAME
  })

  # Factory and constants for route
  ROUTE_INPUT = {
    status: Faker::Lorem.word,
    unserved: { Faker::Lorem.word => Faker::Lorem.word },
    num_unserved: 1,
    distances: { Faker::Lorem.word => 10 },
    total_distance: 10,
    total_working_time: 20,
    total_travel_time: 30,
    total_break_time: 40,
    total_idle_time: 50,
    total_visit_lateness: 60,
    num_late_visits: 2,
    vehicle_overtime: 70,
    total_overtime: 80
  }
  ROUTE = RoutificApi::Route.new(ROUTE_INPUT)


  # Factory and constants for options
  ROUTE_OPTIONS_TRAFFIC = "slow"
  ROUTE_OPTIONS_MIN_VISITS_PER_VEHICLE = "2"
  ROUTE_OPTIONS_BALANCE = "false"
  ROUTE_OPTIONS_MIN_VEHICLES = "false"
  ROUTE_OPTIONS_SHORTEST_DISTANCE = "false"
  ROUTE_OPTIONS_SQUASH_DURATIONS = 1
  ROUTE_OPTIONS_MAX_VEHICLE_OVERTIME = 10
  ROUTE_OPTIONS_MAX_VISIT_LATENESS = 20
  ROUTE_OPTIONS_PARAMS = {
    "traffic"                => ROUTE_OPTIONS_TRAFFIC,
    "min_visits_per_vehicle" => ROUTE_OPTIONS_MIN_VISITS_PER_VEHICLE,
    "balance"                => ROUTE_OPTIONS_BALANCE,
    "min_vehicles"           => ROUTE_OPTIONS_MIN_VEHICLES,
    "shortest_distance"      => ROUTE_OPTIONS_SHORTEST_DISTANCE,
    "squash_durations"       => ROUTE_OPTIONS_SQUASH_DURATIONS,
    "max_vehicle_overtime"   => ROUTE_OPTIONS_MAX_VEHICLE_OVERTIME,
    "max_visit_lateness"     => ROUTE_OPTIONS_MAX_VISIT_LATENESS
  }
  ROUTE_OPTIONS = RoutificApi::Options.new(ROUTE_OPTIONS_PARAMS)

  # Factory and constants for job
  JOB_ID = Faker::Lorem.word
  JOB_INPUT = { visits: { Faker::Lorem.word => VISIT },
                fleet: { Faker::Lorem.word => VEHICLE } },
  ROUTE_PARAMS_STRING = {}
  ROUTE_INPUT.each { |k, v| ROUTE_PARAMS_STRING[k.to_s] = v }
  JOB_PARAMS = {
    "id" => JOB_ID,
    "status" => Faker::Lorem.word,
    "created_at" => "2000-00-00 00:00:00.000Z",
    "finished_at" => "2001-00-00 00:00:00.000Z",
    "output" => ROUTE_PARAMS_STRING
  }

  class RoutificMock
    attr_reader :job_id

    def update_job(job_id)
      @job_id = job_id
      JOB_PARAMS
    end
  end

  JOB_ROUTIFIC_INSTANCE = RoutificMock.new
  JOB = RoutificApi::Job.new(JOB_ID, JOB_INPUT, JOB_ROUTIFIC_INSTANCE)
end
