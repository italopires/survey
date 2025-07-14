require 'rails_helper'

RSpec.describe Division, type: :model do
  context 'relationship' do
    it { is_expected.to have_many(:departments) }
  end

  context 'validates' do
    it { is_expected.to validate_presence_of :name }
  end
end
