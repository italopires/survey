class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :name, :personal_email, :corporate_email, :area,
    :role, :role_kind, :location, :company_tenure, :gender, :generation,
    :sub_team_id

  belongs_to :sub_team, optional: true
  has_many :employee_answers
end