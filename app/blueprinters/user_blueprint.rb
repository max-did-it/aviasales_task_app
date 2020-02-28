class UserBlueprint < Blueprinter::Base
  identifier :id
  fields :email, :name

  view :subscribe do
    association :programs, blueprint: Users::ProgramBlueprint, view: :subscribe
  end
end