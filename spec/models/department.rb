require 'rails_helper'

RSpec.describe Department, type: :model do
  context 'relationship' do
    it { is_expected.to belong_to(:division) }
    it { is_expected.to have_many(:teams) }
  end

  context 'validates' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :division_id }
  end
end
