# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hscode_heading do
    category { Faker::Number.between(1000, 9999)}
    description { Faker::Lorem.sentence }
    association :hscode_chapter
  end
end
