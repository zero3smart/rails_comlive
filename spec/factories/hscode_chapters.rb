# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hscode_chapter do
    sequence(:category, 10)
    description { Faker::Lorem.sentence }
    association :hscode_section
  end
end