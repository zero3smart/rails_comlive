# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hscode_subheading do
    sequence(:category, 100000)
    description { Faker::Lorem.sentence }
    association :hscode_heading
  end
end
