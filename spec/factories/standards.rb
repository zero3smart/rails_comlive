# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :standard do
    name { Faker::Company.name }
    description { Faker::Lorem.sentence }
    code { Faker::Number.number(4) }
    version { Faker::Number.digit }
    logo { Faker::Company.logo }
    certifier { Faker::Company.name }
    certifier_url { Faker::Internet.url }
    official false
    association :brand

    factory :official_standard do
      official true
    end

    factory :invalid_standard do
      name nil
    end
  end
end
