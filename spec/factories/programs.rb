FactoryBot.define do
  factory :program do
    title { FFaker::Book.title }
    description { FFaker::Book.description[0,200] }
  end
end
