# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :packaging do
    uom { Faker::Lorem.word }
    quantity { Faker::Number.decimal(2) }
    name { Faker::Name.name  }
    description { Faker::Lorem.sentence }
    association :commodity_reference

    factory :invalid_packaging do
      name nil
    end
  end
end