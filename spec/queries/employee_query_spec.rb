require 'rails_helper'

RSpec.describe EmployeeQuery do
  let!(:sub_team_1) { create(:sub_team, name: 'sub_team 1') }
  let!(:sub_team_2) { create(:sub_team, name: 'sub_team 2') }
  let!(:employee_1) do
    create(:employee, name: 'João Silva', personal_email: 'joao@example.com',
      corporate_email: 'joao@empresa.com', area: 'TI', role: 'Desenvolvedor', role_kind: 'Pleno',
      location: 'SP', company_tenure: 2, gender: 'male', generation: 'millennial',
      sub_team_id: sub_team_1.id)
  end
  let!(:employee_2) do
    create(:employee, name: 'Maria Souza', personal_email: 'maria@example.com',
      corporate_email: 'maria@empresa.com', area: 'RH', role: 'Analista', role_kind: 'Sênior',
      location: 'RJ', company_tenure: 5, gender: 'female', generation: 'gen_z',
      sub_team_id: sub_team_2.id)
  end

  describe '.call' do
    it 'filters by name' do
      result = described_class.call(Employee.all, name: 'João')
      expect(result).to contain_exactly(employee_1)
    end

    it 'filters by personal_email' do
      result = described_class.call(Employee.all, personal_email: 'joao@')
      expect(result).to contain_exactly(employee_1)
    end

    it 'filters by corporate_email' do
      result = described_class.call(Employee.all, corporate_email: 'maria@empresa')
      expect(result).to contain_exactly(employee_2)
    end

    it 'filters by area' do
      result = described_class.call(Employee.all, area: 'TI')
      expect(result).to contain_exactly(employee_1)
    end

    it 'filters by role' do
      result = described_class.call(Employee.all, role: 'Analista')
      expect(result).to contain_exactly(employee_2)
    end

    it 'filters by role_kind' do
      result = described_class.call(Employee.all, role_kind: 'Pleno')
      expect(result).to contain_exactly(employee_1)
    end

    it 'filters by location' do
      result = described_class.call(Employee.all, location: 'SP')
      expect(result).to contain_exactly(employee_1)
    end

    it 'filters by company_tenure' do
      result = described_class.call(Employee.all, company_tenure: 5)
      expect(result).to contain_exactly(employee_2)
    end

    it 'filters by gender' do
      result = described_class.call(Employee.all, gender: 'female')
      expect(result).to contain_exactly(employee_2)
    end

    it 'filters by generation' do
      result = described_class.call(Employee.all, generation: 'millennial')
      expect(result).to contain_exactly(employee_1)
    end

    it 'filters by sub_team_id' do
      result = described_class.call(Employee.all, sub_team_id: sub_team_2)
      expect(result).to contain_exactly(employee_2)
    end

    it 'paginates results' do
      result = described_class.call(Employee.all, page: 1, per_page: 1)
      expect(result.count).to eq(1)
    end

    it 'returns all when no filters are given' do
      result = described_class.call(Employee.all, {})
      expect(result).to match_array([employee_1, employee_2])
    end
  end
end
