
FactoryBot.define do
  factory :question do
    title { Faker::Lorem.question }
    association :survey
  end
end
