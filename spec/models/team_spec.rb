require 'rails_helper'

RSpec.describe Team, type: :model do
  context 'relationship' do
    it { is_expected.to belong_to(:department) }
    it { is_expected.to have_many(:sub_teams) }
  end

  context 'validates' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :department_id }
  end
end
