class Programs::UsersController < ApplicationController
  def ban
    result = Programs::BanUser.new.call(user_id, program)
    render json: result[0], status: result[1]
  end

  private

  def program
    Program.find(params[:id])
  end

  def user_id
    params.require(:user).require(:id)
  end
end