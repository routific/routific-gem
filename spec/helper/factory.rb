class Factory
  LOCATION_1_ID = Faker::Lorem.word
  LOCATION_2_ID = Faker::Lorem.word
  LOCATION_3_ID = Faker::Lorem.word

  # Factory and constants for location
  LOCATION_NAME = Faker::Lorem.word
  LOCATION_LATITUDE = Faker::Address.latitude.to_f
  LOCATION_LONGITUDE = Faker::Address.longitude.to_f
  LOCATION_PARAMS = {
    "name"  => LOCATION_NAME,
    "lat"   => LOCATION_LATITUDE,
    "lng"   => LOCATION_LONGITUDE
    }
  LOCATION = Location.new(LOCATION_PARAMS)

  # Factory and constants for visit
  VISIT_START = "08:00"
  VISIT_END = "22:00"
  VISIT_DURATION = Faker::Number.digit
  VISIT_DEMAND = Faker::Number.digit
  VISIT_PARAMS = {
    "start"     => VISIT_START,
    "end"       => VISIT_END,
    "duration"  => VISIT_DURATION,
    "demand"    => VISIT_DEMAND
    }
  VISIT = Visit.new(VISIT_PARAMS)

  # Factory and constants for vehicle
  VEHICLE_NAME = Faker::Lorem.word
  VEHICLE_START_LOCATION = LOCATION_1_ID
  VEHICLE_END_LOCATION = LOCATION_3_ID
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
  VEHICLE = Vehicle.new(VEHICLE_PARAMS)

  # Factory and constants for way point
  WAY_POINT_LOCATION_ID = LOCATION_2_ID
  WAY_POINT_LOCATION_NAME = Faker::Lorem.word
  WAY_POINT_ARRIVAL_TIME = "09:00"
  WAY_POINT_FINISH_TIME = "09:10"
  WAY_POINT = WayPoint.new( WAY_POINT_LOCATION_ID, WAY_POINT_LOCATION_NAME,
    WAY_POINT_ARRIVAL_TIME, WAY_POINT_FINISH_TIME )

  # Factory and constants for route
  ROUTE_STATUS = Faker::Lorem.word
  ROUTE_FITNESS = Faker::Lorem.word
  ROUTE_UNSERVED = [Faker::Lorem.word]
  ROUTE = Route.new( ROUTE_STATUS, ROUTE_FITNESS, ROUTE_UNSERVED )
end