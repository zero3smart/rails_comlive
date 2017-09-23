# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hscode_section do
    sequence :category do |i|
      (1..500).to_a.map{|s| s.to_s.rjust(2,"0") }.in_groups_of(5).map{|x| x[0] + "-" + x[4]}[i]
    end
    description { Faker::Lorem.sentence }
  end
end
