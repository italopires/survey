class FeelingsController < ApplicationController
  def analyse
    comments = EmployeeAnswer.pluck('comment')
    return render json: { error: 'No comments provided' }, status: :bad_request if comments.empty?

    result = FeelingAnalysisService.new(comments).call
    render json: result
  end
end
