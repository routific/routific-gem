module RoutificApi
  # This class represents a job returned by vrp-long 
  class Job
    attr_reader :input, :id, :status, :created_at, :finished_at, :output, :routific
    STATUSES = ['pending-geocode', 'pending', 'processing', 'finished', 'error']

    # Constructor
    def initialize(id, input, routific)
      @id = id
      @input = input
      @routific = routific
      @status = 'pending'
    end

    def update
      @routific.updateJob(@id)
    end
  end
end
