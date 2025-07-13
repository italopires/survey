class QuestionOption < ApplicationRecord
  belongs_to :question
  has_many :employee_answers

  validates :question_id, :value, presence: true
end
