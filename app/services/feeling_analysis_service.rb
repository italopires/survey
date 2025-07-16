class FeelingAnalysisService
  include HTTParty
  base_uri 'http://sentiment_api:5001' # sentiment_api:5001 localhost:5001

  def initialize(comments)
    @comments = comments
  end

  def call
    responses = @comments.map do |comment|
      {
        comment: comment,
        analysis: analyze_comment(comment)
      }
    end

    grouped = responses.group_by { |r| r[:analysis]['feeling'] }

    {
      summary: {
        total: responses.size,
        positive: grouped['positive']&.size || 0,
        negative: grouped['negative']&.size || 0,
        neutral: grouped['neutral']&.size || 0,
      },
      examples: {
        positive: grouped['positive']&.first(3)&.map { |r| r[:comment] } || [],
        negative: grouped['negative']&.first(3)&.map { |r| r[:comment] } || [],
        neutral: grouped['neutral']&.first(3)&.map { |r| r[:comment] } || [],
      },
    }
  end

  private

  def analyze_comment(comment)
    response = self.class.post(
      '/analyze',
      headers: { 'Content-Type' => 'application/json' },
      body: { comment: comment }.to_json
    )
  rescue => e
    { sentiment: 'error', error: e.message }
  end
end
