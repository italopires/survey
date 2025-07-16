require 'rails_helper'

RSpec.describe Employee, type: :model do
  context 'relationship' do
    it { is_expected.to belong_to(:sub_team).optional }
    it { is_expected.to have_many(:employee_answers) }
  end

  context 'enumerations' do
    it do
      is_expected.to define_enum_for(:gender)
        .with_values(male: 0, female: 1, other: 2)
    end
  end

  context 'validates' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :personal_email }
    it { is_expected.to validate_presence_of :corporate_email }
    it { is_expected.to validate_presence_of :area }
    it { is_expected.to validate_presence_of :role }
    it { is_expected.to validate_presence_of :role_kind }
    it { is_expected.to validate_presence_of :location }
    it { is_expected.to validate_presence_of :company_tenure }
    it { is_expected.to validate_presence_of :gender }
    it { is_expected.to validate_presence_of :generation }
    it { is_expected.to validate_presence_of :sub_team_id }
  end
end
