# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hscode_chapter do
    category { SecureRandom.urlsafe_base64(1) }
    description { Faker::Lorem.sentence }
    association :hscode_section
  end
end