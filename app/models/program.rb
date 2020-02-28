class Program < ApplicationRecord
  has_many :programs_users
  has_many :users, through: :programs_users
  validates :title, presence: true
  validates :description, presence: true

  scope :active, ->() { joins(:programs_users).where(programs_users: {active: true}) }
  
  scope :by_term, ->(term) do 
    joins(:programs_users).
    select(:id, :title, :description, "COUNT(`user_id`) as users_subscribed").
    where('title LIKE ?', "%#{term}%").
    group(:id).
    order(users_subscribed: :desc)
  end

  def self.blueprint_options
    {
      root: :program
    }
  end
end
