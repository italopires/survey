require 'rails_helper'

RSpec.describe EmployeeAnswer, type: :model do
  context 'relationship' do
    it { is_expected.to belong_to(:employee) }
    it { is_expected.to belong_to(:question) }
    it { is_expected.to belong_to(:question_option) }
  end
end
