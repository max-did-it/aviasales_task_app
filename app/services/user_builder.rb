class UserBuilder
  def initialize(serializer)
    @serializer = serializer
  end

  def call(parameters)
    user = User.new parameters
    if user.save
      [{ success: true}.merge(@serializer.render_as_hash(user, User.blueprint_options)), :created]
    else 
      [{ success: false, errors: user.errors.to_h }, :bad_request]
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