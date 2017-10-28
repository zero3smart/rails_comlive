# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :barcode do
    format { BARCODE_FORMATS.sample }
    content { Faker::Code.isbn  }
    association :barcodeable, factory: :commodity

    factory :invalid_barcode do
      format nil
    end
  end
end