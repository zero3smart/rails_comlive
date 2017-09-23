# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :app_access do
    owner false
    contributor false
    added_by
    association :app
    association :classification
  end
end
