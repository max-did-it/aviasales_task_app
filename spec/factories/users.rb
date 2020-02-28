FactoryBot.define do
  factory :user do
    name { FFaker::Internet.user_name }
    email { FFaker::Internet.unique.email }
  end
end
