require 'descriptive_statistics'

class PlayerCalculationService
  def initialize(partial_calculation_object)
    @season = get_current_season
    @week_of = partial_calculation_object[:week_of]
    @user_id = partial_calculation_object[:user_id]
  end

  # service wont work
  def get_player_calculation(partial_calculation_object)
    @season = get_current_season
    @week_of = partial_calculation_object[:week_of]
    @user_id = partial_calculation_object[:user_id]

    @player_calculation = PlayerCalculation.new
    @player_calculation.week_of = @week_of
    @player_calculation.user_id = @user_id
    @player_calculation.season = @season
    # must start on a monday
    if (User.find(@user_id).nil?)
      return nil
    end

    # get start of week/end of week
    start_week = DateTime.new(@player_calculation.week_of.year, @player_calculation.week_of.month, @player_calculation.week_of.day, 0,0,0, @player_calculation.week_of.strftime( "%z" ));
    end_week = DateTime.new(@player_calculation.week_of.year, @player_calculation.week_of.month, @player_calculation.week_of.day, 23,59,59,  @player_calculation.week_of.strftime( "%z" )) + 6;

    all_player_post = Survey.for_user(@player_calculation.user_id).post_practice.surveys_for_week(start_week, end_week)
    all_player_wellness = Survey.for_user(@player_calculation.user_id).daily_wellness.surveys_for_week(start_week, end_week)

    # set daily wellness fields

    sleep_quality_list = []
    sleep_amount_list =[]
    hydration_quality_list = []
    hydration_amount_list = []
    academic_stress_list = []
    life_stress_list = []


    # wellness
    all_player_wellness.each do |s|
      sleep_quality_list << s.quality_of_sleep
      sleep_amount_list << s.hours_of_sleep
      hydration_quality_list << 1 ? s.hydration_quality : hydration_quality_list << 0
      hydration_amount_list << s.ounces_of_water_consumed
      academic_stress_list << s.academic_stress
      life_stress_list << s.life_stress
    end

    @player_calculation.sleep_quality_average = sleep_quality_list.mean
    @player_calculation.sleep_amount_average = sleep_amount_list.mean
    @player_calculation.hydration_quality_average = hydration_quality_list.mean
    @player_calculation.hydration_amount_average = hydration_amount_list.mean
    @player_calculation.academic_stress_average = academic_stress_list.mean
    @player_calculation.life_stress_average = life_stress_list.mean

    # post practice
    daily_load_list = []

    latest_survey = all_player_post.chronological.first
    if latest_survey.nil?
      return nil
    end

    # set params from latest post practice survey
    @player_calculation.weekly_load = latest_survey.weekly_load
    @player_calculation.weekly_strain = latest_survey.weekly_strain
    @player_calculation.week_to_week_weekly_load_percent_change = latest_survey.week_to_week_weekly_load_percent_change
    @player_calculation.monotony = latest_survey.monotony

    player_performance_list = []
    practice_difficulty_average_list = []
    all_player_post.each do |s|
      player_performance_list << s.player_personal_performance
      practice_difficulty_average_list << s.player_rpe_rating

    end

    @player_calculation.practice_difficulty_average = practice_difficulty_average_list.mean
    @player_calculation.personal_performance_average = player_performance_list.mean

    return @player_calculation
  end

  def get_current_season
    current_month = Time.now.month
    current_year = Time.now.year
    current_year = current_year.to_s
    # Fall Season
    if 8 <= current_month && current_month <= 12
      current_seasons = ("Fall-" + current_year)
    end
    if 11 <= current_month || current_month <= 3
      current_seasons = ("Winter-" + current_year)
    end
    if 2 <= current_month && current_month <= 6
      current_seasons = ("Spring-" + current_year)
    end
    if current_seasons == []
      current_seasons = ("Other-" + current_year)
    end
    return current_seasons
  end

end
