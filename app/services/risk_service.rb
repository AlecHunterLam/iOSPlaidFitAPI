require 'descriptive_statistics'

class SurveyService
  def initialize(params)
    @user_id = params[:user_id]
    @team_id = User.find(@user_id).teams

    @most_recent_post = Survey.for_user(@user_id).chronological.post_practice.first

    @at_risk_boolean = nil

    if !(@most_recent_post.nil?)
      @at_risk_boolean = calculate_risk
    end
  end

  def calculate_risk

  end

end
