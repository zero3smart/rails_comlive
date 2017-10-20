# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reference do
    kind { %w(specific_of variation_of alternative_to).sample }
    source_commodity_reference_id { create(:generic_commodity_reference).id }
    target_commodity_reference_id { create(:non_generic_commodity_reference).id }
    description { Faker::Lorem.paragraph }
    association :app

    factory :invalid_reference do
      description nil
    end
  end
end