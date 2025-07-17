require 'rails_helper'

RSpec.describe FeelingsController, type: :controller do
  describe 'GET #analyse' do
    context 'when comments are present' do
      let!(:employee) { create(:employee) }
      let!(:question) { create(:question) }
      let!(:option)   { create(:question_option, question: question) }
      let(:service_double) do
        double(call: {
          summary: { total: 1, positive: 1, negative: 0, neutral: 0 },
          examples: { positive: ['Ambiente excelente!'], negative: [], neutral: [] }
        })
      end

      before do
        create(:employee_answer, comment: 'Ambiente excelente!', employee: employee, question: question, question_option: option)

        allow(FeelingAnalysisService).to receive(:new).and_return(service_double)
      end

      it 'returns success with analysis result' do
        get :analyse
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)

        expect(json['summary']['total']).to eq(1)
        expect(json['examples']['positive']).to include('Ambiente excelente!')
      end
    end

    context 'when no comments are present' do
      it 'returns bad request' do
        get :analyse
        expect(response).to have_http_status(:bad_request)

        json = JSON.parse(response.body)
        expect(json['error']).to eq('No comments provided')
      end
    end
  end
end
