# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    url { Faker::Internet.url }
    description { Faker::Lorem.paragraph }
    association :app
    association :commodity

    factory :invalid_link do
      url nil
    end
  end
end
