# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    provider "auth0"
    uid { "uid|#{Faker::Crypto.md5}" }
    oauth_token { Faker::Lorem.characters(16)  }
  end
end