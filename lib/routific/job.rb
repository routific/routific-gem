module RoutificApi
  # This class represents a job returned by vrp-long 
  class Job
    FIELDS = [:status, :created_at, :finished_at, :output]
    attr_reader *FIELDS
    attr_reader :input, :id, :routific

    # Constructor
    def initialize(id, input, routific)
      @id = id
      @input = input
      @routific = routific
      @status = 'pending'
    end

    def update
      job_data = @routific.get_job(@id)
      FIELDS.each do |field|
        set_instance_variable "@#{field}", job_data[field.to_str]
      end
    end
  end
end
