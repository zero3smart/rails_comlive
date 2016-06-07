# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :measurement do
    property "energy"
    value { Faker::Number.decimal(2,4) }
    uom "J"
    association :app

    factory :invalid_measurement do
      property nil
    end
  end
end
