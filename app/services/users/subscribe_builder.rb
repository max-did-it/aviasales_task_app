class Users::SubscribeBuilder
  def initialize(serializer)
    @serializer = serializer
  end

  def call(user, parameters)
    program = Program.find_by(parameters)
    return program_not_found if program.blank?

    prog_us = ProgramsUser.new program: program, user: user

    if prog_us.save
      resp = @serializer.render_as_hash(
        user, 
        User.blueprint_options.merge!(view: :subscribe)
      )
      [{ success: true}.merge(resp),:created]
    else
      [
        { success: false, 
          errors: [prog_us.errors.to_h] 
        }, 
        :bad_request
      ]
    end
  # rescue StandardError => e
  #   [{
  #     success: false, 
  #     errors: ["An error has occurred, 
  #       and engineers have been informed.
  #       Please try later", e]
  #     }, 
  #     :internal_server_error
  #   ]
  end

  def program_not_found
    [{
      success: false, 
      errors: [
        program: 'not found'
      ]
      }, 
      :not_found
    ]
  end
end