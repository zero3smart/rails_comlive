# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :classification do
    name { Faker::App.name }
    description { Faker::Lorem.paragraph }
    moderator
    association :app

    factory :invalid_classification do
      name nil
    end
  end
end
