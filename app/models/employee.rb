class Employee < ApplicationRecord
  belongs_to :sub_team, optional: true
  has_many :employee_answers

  validates :name, :personal_email, :corporate_email, :phone_number,
    :area, :role, :role_kind, :position, :location,
    :company_tenure, :gender, :generation, :sub_team_id, presence: true
  
  validates :personal_email, :corporate_email, uniqueness: true

  enum gender: {
    male: 0,
    female: 1,
    other: 2
  }
end
