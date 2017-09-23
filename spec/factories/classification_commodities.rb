# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :classification_commodity do
    needs_moderation { Faker::Boolean.boolean }
    association :level
    association :commodity
    added_by
  end
end
