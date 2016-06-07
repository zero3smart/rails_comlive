# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hscode_subheading do
    category { Faker::Number.between(100000, 999999)}
    description { Faker::Lorem.sentence }
    association :hscode_heading
  end
end
