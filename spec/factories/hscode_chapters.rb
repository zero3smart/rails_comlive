# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hscode_chapter do
    category { Faker::Number.between(10, 99)}
    description { Faker::Lorem.sentence }
    association :hscode_section
  end
end
