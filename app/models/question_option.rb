class QuestionOption < ApplicationRecord
  belongs_to :question
  has_many :employee_answers
end
