# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hscode_chapter do
    category { ('a'..'z').to_a.shuffle.sample(2).join }
    description { Faker::Lorem.sentence }
    association :hscode_section
  end
end