# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :classification_standard do
    inheritable { Faker::Boolean.boolean }
    force { Faker::Boolean.boolean }
    needs_moderation { Faker::Boolean.boolean }
    added_by
    association :level
    association :standard
  end
end
