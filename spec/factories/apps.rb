# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :app do
    name { Faker::App.name}
    description { Faker::Lorem.paragraph }

    factory :invalid_app do
      name nil
    end
  end
end