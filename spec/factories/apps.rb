# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :app do
    association :user

    description { Faker::Lorem.paragraph }

    factory :invalid_app do
      description nil
    end
  end
end
