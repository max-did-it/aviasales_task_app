class ProgramsUser < ApplicationRecord
  belongs_to :program
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :program_id, message: "Already subscribed"
end
