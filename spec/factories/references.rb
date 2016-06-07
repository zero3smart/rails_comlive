# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reference do
    kind { %w(specific_of variation_of alternative_to).sample }
    source_commodity_id { create(:commodity, generic: true).id }
    target_commodity_id { create(:commodity).id }
    description { Faker::Lorem.paragraph }
    association :app

    factory :invalid_reference do
      description nil
    end
  end
end
