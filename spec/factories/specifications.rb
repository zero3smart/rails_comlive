# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :specification do
    property "energy"
    value { Faker::Number.decimal(2,4) }
    uom "J"
    association :parent, factory: :commodity

    factory :spec_with_min_max do
      min { Faker::Number.decimal(2,4) }
      max { Faker::Number.decimal(2,4) }
      value nil
    end

    factory :invalid_specification do
      property nil
    end
  end
end