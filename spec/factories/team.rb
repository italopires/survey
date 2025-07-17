
FactoryBot.define do
  factory :team do
    name { Faker::Team.name }
    association :department
  end
end
