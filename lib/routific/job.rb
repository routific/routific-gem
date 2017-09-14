module RoutificApi
  # This class represents a job returned by vrp-long 
  class Job
    FIELDS = [:status, :created_at, :finished_at]
    attr_reader *FIELDS
    attr_reader :input, :id, :routific, :route

    # Constructor
    def initialize(id, input, routific)
      @id = id
      @input = input
      @routific = routific
      @status = 'pending'
    end

    def update
      job_data = @routific.update_job(@id)
      FIELDS.each do |field|
        set_instance_variable "@#{field}", job_data[field.to_s]
      end
      @route = RoutificApi::Route.parse(job["output"]) if job["output"]
    end
  end
end
