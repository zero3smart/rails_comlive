# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :barcode do
    name { Faker::Hacker.noun }
    format "bookland"
    content { Faker::Code.isbn  }
    association :barcodeable, factory: :commodity

    factory :invalid_barcode do
      format nil
    end
  end
end
