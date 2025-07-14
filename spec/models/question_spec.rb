require 'rails_helper'

RSpec.describe Question, type: :model do
  context 'relationship' do
    it { is_expected.to belong_to(:survey) }
    it { is_expected.to have_many(:question_options) }
    it { is_expected.to have_many(:employee_answers) }
  end

  context 'validates' do
    it { is_expected.to validate_presence_of :survey_id }
    it { is_expected.to validate_presence_of :title }
  end
end
