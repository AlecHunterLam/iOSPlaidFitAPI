class RiskService
  def initialize(params)
    @user_id = params[:user_id]
    @team_id = User.find(@user_id).teams

    @most_recent_post = Survey.for_user(@user_id).chronological.post_practice.first
    @most_recent_daily = Survey.for_user(@user_id).chronological.daily_wellness.first

    post_risk = false
    daily_wellness_risk = false

    if !(@most_recent_post.nil?)
      post_risk = calculate_risk_post
    end

    if !(@most_recent_daily.nil?)
      daily_wellness_risk = calculate_risk_daily_wellness
    end

    @at_risk_boolean = daily_wellness_risk || post_risk

  end

  # Post Practice Risk
  def calculate_risk_post
    # Comments = At Risk Criteria

    # weekly load increase by 25%
    if @most_recent_post.week_to_week_weekly_load_percent_change >= 25
      return true
    # a:c ratio > 1.5
    elsif @most_recent_post.a_c_ratio >= 1.5 || @most_recent_post.a_c_ratio < 0.8
      return true
    # freshness index <= -200
    elsif @most_recent_post.freshness_index <= -200
      return true
    # monotony > 2
    elsif @most_recent_post.monotony > 2
      return true
    # does not meet any at risk criteria
    else
      return false
    end
  end

  # Daily Wellness Risk
  def calculate_risk_daily_wellness
    # Comments = At Risk Criteria

    # less than 3 hours of sleep
    if @most_recent_daily.hours_of_sleep < 3
      return true
    # less than 16 ounces of water consumed
    elsif @most_recent_daily.ounces_of_water_consumed < 16
      return true
    # both forms of stress <= 2
    elsif @most_recent_daily.academic_stress <= 2 && @most_recent_daily.life_stress <= 2
      return true
    # does not meet any at risk criteria
    else
      return false
    end







  end
end
