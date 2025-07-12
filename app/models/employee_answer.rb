class EmployeeAnswer < ApplicationRecord
  belongs_to :employee
  belongs_to :question
  belongs_to :question_option
end
