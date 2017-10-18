# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :brand do
    name { Faker::Company.name }
    official false
    logo { Faker::Company.logo }
    description { Faker::Lorem.sentence }

    factory :invalid_brand do
      name nil
    end

    factory :official_brand do
      official true
    end
  end
end