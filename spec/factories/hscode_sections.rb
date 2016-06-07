# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hscode_section do
    category { Faker::Number.between(1, 99)}
    description { Faker::Lorem.sentence }
  end
end
