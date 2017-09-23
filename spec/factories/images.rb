# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    url { Faker::Company.logo }
    commodity_reference

    factory :invalid_image do
      url nil
    end
  end
end
