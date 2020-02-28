class UsersController < ApplicationController
  default_serializer UserBlueprint

  def show
    json = default_serializer.render(user, User.blueprint_options)
    render json: json
  end

  def index
    render json: default_serializer.render(User.all, User.blueprint_options)
  end

  def create
    result = UserBuilder.new(default_serializer).call(user_parameters)
    render json: result[0], status: result[1]
  end

  private

  def user
    User.find(params[:id])
  end

  def user_parameters
    params.require(:user).permit(:email, :name)
  end
end
