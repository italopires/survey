class Employee < ApplicationRecord
  include Discard::Model

  self.discard_column = :deleted_at

  belongs_to :sub_team, optional: true
  has_many :employee_answers

  validates :name, :personal_email, :corporate_email,
    :area, :role, :role_kind, :location, :company_tenure,
    :gender, :generation, :sub_team_id, presence: true

  validates :personal_email, :corporate_email, uniqueness: true

  enum :gender, {
    male: 0,
    female: 1,
    other: 2
  }
end
