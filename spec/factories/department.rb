
FactoryBot.define do
  factory :department do
    name { Faker::Commerce.department }
    association :division
  end
end
