# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reference do
    kind { %w(specific_of variation_of alternative_to).sample }
    source_commodity_id { create(:generic_commodity).id }
    target_commodity_id { create(:non_generic_commodity).id }
    description { Faker::Lorem.paragraph }
    association :app
    association :commodity_reference

    factory :invalid_reference do
      description nil
    end
  end
end