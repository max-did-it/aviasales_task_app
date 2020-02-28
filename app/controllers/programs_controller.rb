class ProgramsController < ApplicationController
  default_serializer ProgramBlueprint
  def index
    render json: default_serializer.render(Program.all)
  end

  def create
    result = ProgramBuilder.new(default_serializer).call(program_parameters)
    render json: result[0], status: result[1]
  end

  def search
    programs = Program.by_term(params[:term])
    render json: default_serializer.render(programs)
  end

  private 

  def program_parameters
    params.require(:program).permit(:title, :description)
  end
end
