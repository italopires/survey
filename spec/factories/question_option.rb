
FactoryBot.define do
  factory :question_option do
    value { Faker::Lorem.word }
    association :question
  end
end
