
FactoryBot.define do
  factory :sub_team do
    name { Faker::Team.creature }
    association :team
  end
end
