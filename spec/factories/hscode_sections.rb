# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hscode_section do
    category { ["01-10","11-15", "16-20","21-25"].sample }
    description { Faker::Lorem.sentence }
  end
end