


require 'descriptive_statistics'

SECONDS_IN_ONE_DAY = 86400


class SurveyService

  def initialize(params)
    # set  universal parameters
    @user_id = params[:user_id]
    @team_id = params[:team_id]
    @practice_id = params[:practice_id]
    # set user object
    @user = User.find(@user_id)
    @team = Team.find(@team_id)

    @survey_type = params[:survey_type]
    @completed_time = Time.now

    if @team.nil? || @user.nil? || @survey_type != 'Daily Wellness' || @survey_type != 'Post-Practice'
      return nil
    end

    @season = (@team.season).to_s.capitalize + '-' + (Time.now.year).to_s

    # if a daily-wellness, set appropriate fields to nil, and set data fields
    if (@survey_type == 'Daily Wellness')
      set_daily_wellness_survey(params)

    # if a post-practice, set appropriate fields to nil, and set data fields
    # elsif (@survey_type == 'Post-Practice')
    else
      if Practice.find(@practice_id).nil? || !validate_fields_for_calculations(params)
        return nil
      end
      set_post_practice_survey(params)
    end
  end

  private

  def validate_fields_for_calculations(params)
    rpe = params[:player_rpe_rating]
    performance = params[:player_personal_performance]
    full_practice = params[:participated_in_full_practice]
    minutes = params[:minutes_participated]
    # nill checks
    if rpe.nil? || performance.nil? || full_practice.nil?
      return false
    # type checks
    elsif (!validate_integer_type(rpe) || !validate_integer_type(performance) || !validate_boolean_type(full_practice) || !validate_integer_type(minutes))
      return false
    # practice + minutes check
    elsif (full_practice == false && minutes.nil?)
      return false
    # pass preliminary checks
    else
      return true
    end

  end

  def set_daily_wellness_survey(params)
    # set proper fields
    @hours_of_sleep = params[:hours_of_sleep]
    @quality_of_sleep = params[:quality_of_sleep]
    @academic_stress = params[:academic_stress]
    @life_stress = params[:life_stress]
    @soreness = params[:soreness]
    @ounces_of_water_consumed = params[:ounces_of_water_consumed]
    @hydration_quality = params[:hydration_quality]

    # set all other fields to nil
    @session_load = nil
    @daily_load = nil
    @daily_strain = nil
    @player_rpe_rating = nil
    @player_personal_performance = nil
    @participated_in_full_practice = nil
    @minutes_participated = nil
    @expected_session_load = nil
    @weekly_strain = nil
    @weekly_load = nil
    @acute_load = nil
    @chronic_load = nil
    @a_c_ratio = nil
    @week_to_week_weekly_load_percent_change = nil

    @practice_id = nil
  end

  def set_post_practice_survey(params)
    # for post practices, we have a practice object
    @practice = Practice.find(@practice_id)



    # set proper fields
    @player_rpe_rating = params[:player_rpe_rating]
    @player_personal_performance = params[:player_personal_performance]
    @participated_in_full_practice = params[:participated_in_full_practice]

    if @participated_in_full_practice == true
      @minutes_participated = @practice.duration
    else
      @minutes_participated = params[:minutes_participated]
    end

    @session_load = set_player_session_load
    @expected_session_load = set_expected_session_load
    @daily_load = params[:daily_load]
    @daily_strain = params[:daily_strain]
    @weekly_strain = params[:weekly_strain]
    @weekly_load = params[:weekly_load]
    @acute_load = params[:acute_load]
    @chronic_load = params[:chronic_load]
    @a_c_ratio = params[:a_c_ratio]
    @week_to_week_weekly_load_percent_change = params[:week_to_week_weekly_load_percent_change]

    # set all other fields to nil
    @hours_of_sleep = nil
    @quality_of_sleep = nil
    @academic_stress = nil
    @life_stress = nil
    @soreness = nil
    @ounces_of_water_consumed = nil
    @hydration_quality = nil


  end

  def set_player_session_load
    player_session_load = @player_rpe_rating * @participated_in_full_practice
    return player_session_load
  end

  def set_expected_session_load
    expected_session_load = @practice.duration * @practice.difficulty
    return expected_session_load
  end

  # VALIDATIONS

  # validate whether a provided field is a boolean type
  def validate_boolean_type(field)
    if field.is_a?(TrueClass) || field.is_a?(FalseClass)
      return true
    else
      return false
    end
  end

  # validate integer type for provided field - MUST BE POSITIVE
  def validate_integer_type(field)
    if field.is_a?(Integer)
      return true
    else
      return false
    end
  end


end
