class Employee < ApplicationRecord
  belongs_to :sub_area, optional: true
  has_many :employee_answers
end
