# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :level do
    name { Faker::App.name  }
    position { Faker::Number.digit }
    needs_moderation false
    added_by
    association :classification

    trait :with_parent do
      association :parent, factory: :level
    end

    factory :invalid_level do
      name nil
    end
  end
end
