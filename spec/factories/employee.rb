
FactoryBot.define do
  factory :employee do
    name { Faker::Name.name }
    personal_email { Faker::Internet.email }
    corporate_email { Faker::Internet.email(domain: "company.com") }
    area { Faker::Commerce.department }
    role { Faker::Job.title }
    role_kind { ["CLT", "PJ"].sample }
    location { Faker::Address.city }
    company_tenure { rand(1..10) }
    gender { Employee.genders.keys.sample }
    generation { ["Z", "Y", "X", "Boomer"].sample }
    association :sub_team
  end
end
