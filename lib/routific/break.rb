module RoutificApi
  # This class represent a vehicle break
  class Break
    REQUIRED_PARAMS = %w{ id start end }

    attr_reader *REQUIRED_PARAMS
    attr_reader :in_transit

    # Constructor
    #
    # Required arguments in params:
    # id: unique identifier for the break (e.g. 'lunch-break')
    # start: start time of the break (e.g. '12:00')
    # end: end time of the break (e.g. '12:30')
    #
    # Optional argument in params:
    # in_transit: whether the vehicle can be in movement during the break (e.g. true). The default value is false.
    def initialize(params)
      validate(params)

      @id = params["id"]
      @start = params["start"]
      @end = params["end"]
      @in_transit = params["in_transit"] unless params["in_transit"].nil?
    end

    def to_json(options = nil)
      as_json(options).to_json
    end

    def as_json(options = nil)
      jsonData = {}
      jsonData["id"] = self.id
      jsonData["start"] = self.start
      jsonData["end"] = self.end
      jsonData["in_transit"] = self.in_transit unless self.in_transit.nil?

      jsonData
    end

    private
    # Validates the parameters being provided
    # Raises an ArgumentError if any of the required parameters is not provided.
    def validate(params)
      REQUIRED_PARAMS.each do |param|
        if params[param].nil?
          raise ArgumentError, "'#{param}' parameter must be provided in break"
        end
      end
    end
  end
end
