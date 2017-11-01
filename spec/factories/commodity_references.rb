# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commodity_reference do
    name { Faker::Team.name }
    short_description { Faker::Company.catch_phrase }
    long_description { Faker::Lorem.paragraph }
    measured_in { %w(length time mass temperature number fraction).sample }
    moderated false
    association :brand
    association :app
    association :commodity

    factory :invalid_commodity_reference do
      name nil
    end

    factory :generic_commodity_reference do
      generic true
      brand nil
    end

    factory :non_generic_commodity_reference do
      generic false
    end
  end
end