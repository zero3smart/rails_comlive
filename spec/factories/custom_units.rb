# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :custom_unit do
    property { Faker::Lorem.word }
    uom { Faker::Address.state_abbr }
    association :app

    factory :invalid_custom_unit do
      property nil
    end
  end
end
