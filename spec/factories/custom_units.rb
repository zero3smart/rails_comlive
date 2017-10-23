# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :custom_unit do
    sequence(:property) {|n| "#{Faker::Lorem.word}-#{n}" }
    sequence(:uom) { |n| "#{Faker::Address.state_abbr}-#{n}" }
    association :app

    factory :invalid_custom_unit do
      property nil
    end
  end
end