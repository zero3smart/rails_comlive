# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :standardization do
    association :standard
    association :user
    association :referable, factory: :brand
  end
end
