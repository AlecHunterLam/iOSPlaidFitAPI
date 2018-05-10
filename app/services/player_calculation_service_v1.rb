require 'descriptive_statistics'

SECONDS_IN_ONE_DAY = 86400

class SurveyService
  def initialize(partial_calculation_object)
    @player_calculation = partial_calculation_object
  end


  def get_player_calculation_object
    # must start on a monday
    if !(Player.find(@player_calculation.user_id).nil?)
      return nil
    end

    # get start of week/end of week
    start_week = DateTime.new(@player_calculation.week_of.year, @player_calculation.week_of.month, @v.week_of.day, 0,0,0, @player_calculation.strftime( "%z" ));
    end_week = DateTime.new(@player_calculation.week_of.year, @player_calculation.week_of.month, @v.week_of.day, 23,59,59, a.strftime( "%z" )) + 6;

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
      hydration_quality_list << s.hydration_quality
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

    @player_calculation.practice_difficulty_average = latest_survey.practice_difficulty_average_list
    @player_calculation.personal_performance_average = latest_survey.player_performance_list

    # daily_loads = []
    # weekly_load = 0

    return @player_calculation
  end
end
