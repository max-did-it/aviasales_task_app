class Program < ApplicationRecord
  has_many :programs_users
  has_many :users, through: :programs_users

  scope :by_term, ->(term) { where('title LIKE ?', "%#{term}%") }

  def self.blueprint_options
    {
      root: :program
    }
  end
end
