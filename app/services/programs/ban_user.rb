class Programs::BanUser
  def call(user_id, program)
    subs = ProgramsUser.find_by(program_id: program.id, user_id: user_id)
    puts subs
    subs.active = false
    if subs.save
      [{success: true, result: ["user #{user_id} successful banned in #{program.title}"]}, :ok]
    else
      [{success: false, errors: [subs.errors.to_h] }, :bad_request]
    end
  end
end
