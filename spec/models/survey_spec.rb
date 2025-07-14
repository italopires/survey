require 'rails_helper'

RSpec.describe Survey, type: :model do
  context 'relationship' do
    it { is_expected.to have_many(:questions) }
  end

  context 'validates' do
    it { is_expected.to validate_presence_of :title }
  end
end
