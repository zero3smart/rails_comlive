# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hscode_heading do
    sequence(:category, 1000)
    description { Faker::Lorem.sentence }
    association :hscode_chapter
  end
end