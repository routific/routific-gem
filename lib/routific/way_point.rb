module RoutificApi
  # This class represents a location to visit in the route
  class WayPoint
    FIELDS = [
      :location_id, :location_name,
      :arrival_time, :finish_time,
      :id, :break, :start, :end, :in_transit, # breaks
      :late_by # visit lateness
    ]

    attr_reader *FIELDS

    # Constructor
    def initialize(options = {})
      FIELDS.each do |field|
        instance_variable_set "@#{field}", options[field.to_s]
      end
    end
  end
end
