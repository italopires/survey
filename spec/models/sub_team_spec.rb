require 'rails_helper'

RSpec.describe SubTeam, type: :model do
  context 'relationship' do
    it { is_expected.to belong_to(:team) }
    it { is_expected.to have_many(:employees) }
  end

  context 'validates' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :team_id }
  end
end
