class EmployeeAnswer < ApplicationRecord
  belongs_to :employee
  belongs_to :question
  belongs_to :question_option

  validates :employee_id, :survey_id, :question_id, presence: true
end
