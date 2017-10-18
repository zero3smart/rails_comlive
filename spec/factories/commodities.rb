# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commodity do
    name { Faker::Team.name }
    short_description nil
    long_description nil
    measured_in { %w(length time mass temparature number fraction).sample }
    association :brand

    factory :invalid_commodity do
      name nil
    end

    factory :generic_commodity do
      generic true
      brand nil
    end

    factory :non_generic_commodity do
      generic false
    end
  end
end