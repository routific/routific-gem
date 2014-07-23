# This class represents a location to be visited
class Visit
  attr_reader :start, :end, :duration, :demand

  # Constructor
  #
  # Optional arguments in params:
  # start: the earliest time for this visit. Default value is 00:00, if not specified.
  # end: the latest time for this visit. Default value is 23:59, if not specified.
  # duration: the length of this visit in minutes
  # demand: the capacity that this visit requires
  def initialize(params = {})
    @start = params["start"]
    @end = params["end"]
    @duration = params["duration"]
    @demand = params["demand"]
  end

  # Returns the JSON representation of this object
  def to_json(options = nil)
    jsonData = {}
    jsonData["start"] = self.start if self.start
    jsonData["end"] = self.end if self.end
    jsonData["duration"] = self.duration if self.duration
    jsonData["demand"] = self.demand if self.demand

    jsonData.to_json
  end
end