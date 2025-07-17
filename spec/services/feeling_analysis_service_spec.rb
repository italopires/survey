require 'rails_helper'

RSpec.describe FeelingAnalysisService do
  let(:comments) do
    [
      'A empresa é excelente para trabalhar.',
      'Ambiente muito tóxico e estressante.',
      'Não tenho opinião formada.'
    ]
  end

  before do
    stub_request(:post, 'http://sentiment_api:5001/analyze')
      .with(
        headers: { 'Content-Type' => 'application/json' }
      ).to_return do |request|
        body = JSON.parse(request.body)
        response = case body['comment']
        when /excelente/
          { feeling: 'positive' }
        when /tóxico/
          { feeling: 'negative' }
        else
          { feeling: 'neutral' }
        end

        { status: 200, body: response.to_json, headers: { 'Content-Type' => 'application/json' } }
      end
  end

  it 'returns feeling summary and examples correctly' do
    result = described_class.new(comments).call

    expect(result[:summary][:total]).to eq(3)
    expect(result[:summary][:positive]).to eq(1)
    expect(result[:summary][:negative]).to eq(1)
    expect(result[:summary][:neutral]).to eq(1)

    expect(result[:examples][:positive]).to include('A empresa é excelente para trabalhar.')
    expect(result[:examples][:negative]).to include('Ambiente muito tóxico e estressante.')
    expect(result[:examples][:neutral]).to include('Não tenho opinião formada.')
  end
end
