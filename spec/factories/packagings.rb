# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :packaging do
    name { Faker::Name.name  }
    description { Faker::Lorem.sentence }
    quantity { Faker::Number.decimal(2) }
    uom { Faker::Lorem.word }
    association :commodity_reference

    factory :invalid_packaging do
      name nil
    end
  end
end
