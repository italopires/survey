
FactoryBot.define do
  factory :employee_answer do
    comment { Faker::Lorem.sentence }
    association :employee
    association :question
    association :question_option
    survey_id { question.survey_id }
  end
end
