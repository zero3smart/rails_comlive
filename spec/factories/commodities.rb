# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commodity do
    short_description { Faker::Lorem.sentence }
    long_description { Faker::Lorem.paragraph }
    generic false
    association :app

    factory :invalid_commodity do
      short_description nil
    end
  end
end
