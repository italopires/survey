require 'rails_helper'

RSpec.describe QuestionOption, type: :model do
  context 'relationship' do
    it { is_expected.to belong_to(:question) }
  end

  context 'validates' do
    it { is_expected.to validate_presence_of :value }
  end
end
