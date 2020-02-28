class ProgramBuilder
  def initialize(serializer)
    @serializer = serializer
  end

  def call(parameters)
    program = Program.new parameters
    if program.save
      [{ success: true}.merge(@serializer.render_as_hash(program, Program.blueprint_options)), :created]
    else 
      [{ success: false, errors: program.errors.to_h }, :bad_request]
    end
  rescue StandardError => _
    [{
      success: false, 
      errors: ['An error has occurred, 
        and engineers have been informed. 
        Please try later']
      }, 
      :internal_server_error
    ]
  end
end