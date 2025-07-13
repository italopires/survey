class Question < ApplicationRecord
  belongs_to :survey
  has_many :question_options
  has_many :employee_answers

  validates :survey_id, :title, presence: true
end
