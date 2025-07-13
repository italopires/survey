class QuestionOption < ApplicationRecord
  belongs_to :question
  has_many :employee_answers

  validates :employee_id, :survey_id, :question_id, :value, presence: true

end
