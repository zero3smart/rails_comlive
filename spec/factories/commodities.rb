# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commodity do
    name { Faker::Team.name }
    measured_in { %w(length time mass temparature number fraction).sample }
    association :brand

    factory :invalid_commodity do
      name nil
    end

    factory :generic_commodity do
      generic true
      brand nil
    end

    factory :non_generic_commodity do
      generic false
    end

    ignore do
      ref_app_id nil
    end

    trait :with_reference do
      after(:create) do |commodity, evaluator|
        create(:commodity_reference, commodity: commodity, app_id: evaluator.ref_app_id)
      end
    end
  end
end
