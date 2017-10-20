# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :standard do
    name { Faker::Company.name }
    description { Faker::Lorem.sentence }
    logo { Faker::Company.logo }
    official false

    factory :official_standard do
      official true
    end

    factory :invalid_standard do
      name nil
    end
  end
end