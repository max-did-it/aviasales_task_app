class Users::ProgramsController < ApplicationController
  default_serializer Users::ProgramBlueprint
  rescue_from ActiveRecord::RecordNotUnique, with: :render_already_exist
  def index
    render json: default_serializer.render(user.programs)
  end

  def create
    result = Users::SubscribeBuilder.new(default_serializer).call(user, subscribe_params)
    render json: result[0], status: result[1]
  end

  private

  def user
    User.find(user_id)
  end
  
  def user_id
    params[:user_id]
  end

  def subscribe_params
    params.require(:program).permit(:id)
  end

  def render_already_exist
    render json: { success: true, result: ['already exist'] }, status: :already_reported
  end
end