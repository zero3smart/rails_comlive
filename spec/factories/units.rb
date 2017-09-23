# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :unit do
    uom { Faker::Hacker.verb }
    value_type { %w(string integer float).sample }
    min { Faker::Number.decimal(2) }
    max { Faker::Number.decimal(2) }
    force { Faker::Boolean.boolean }
    needs_moderation { Faker::Boolean.boolean }
    inheritable { Faker::Boolean.boolean }
    added_by
    association :level
  end
end
