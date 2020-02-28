class User < ApplicationRecord
  has_many :programs_users
  has_many :programs, through: :programs_users
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_uniqueness_of :email, case_sensitive: true

  def self.blueprint_options
    {
      root: :user
    }
  end
end
