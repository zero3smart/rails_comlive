# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    association :sender, factory: :user
    recipient_email { Faker::Internet.email }
    association :app

    factory :invalid_invitation do
      recipient_email "invalid.email"
    end
  end
end
