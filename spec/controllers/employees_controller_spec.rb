require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  describe 'GET #index' do
    let!(:employee_1) { create(:employee, name: 'Alice') }
    let!(:employee_2) { create(:employee, name: 'Bob') }

    it 'returns all employees when no filter is provided' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).map { |e| e['id'] }).to include(employee_1.id, employee_2.id)
    end

    it 'filters employees by name' do
      get :index, params: { name: 'Alice' }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.length).to eq(1)
      expect(json.first['name']).to eq('Alice')
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      attributes_for(:employee).merge(sub_team_id: create(:sub_team).id)
    end

    let(:invalid_attributes) do
      { name: '', personal_email: '', corporate_email: '' }
    end

    it 'creates a new employee with valid attributes' do
      expect {
        post :create, params: { employee: valid_attributes }
      }.to change(Employee, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it 'returns errors with invalid attributes' do
      post :create, params: { employee: invalid_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end

  describe 'GET #show' do
    let(:employee) { create(:employee) }

    it 'returns the employee by id' do
      get :show, params: { id: employee.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(employee.id)
    end
  end

  describe 'PUT #update' do
    let(:employee) { create(:employee, name: 'Old Name') }

    it 'updates the employee' do
      put :update, params: { id: employee.id, employee: { name: 'New Name' } }
      expect(response).to have_http_status(:ok)
      expect(employee.reload.name).to eq('New Name')
    end
  end

  describe 'DELETE #destroy' do
    let!(:employee) { create(:employee) }

    it 'destroys the employee' do
      expect {
        delete :destroy, params: { id: employee.id }
      }.to change(Employee, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
