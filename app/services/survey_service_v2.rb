require 'descriptive_statistics'

SECONDS_IN_ONE_DAY = 86400

class SurveyService
  def initialize(params)

    # set  universal parameters
    @user_id = params[:user_id]
    @team_id = params[:team_id]
    @practice_id = params[:practice_id]

    @survey_type = params[:survey_type]
    # @completed_time = params[:datetime_today].ago(1000) #Time.now # ==> FOR TESTING REASONS, SUPPLY THE CURRENT DATE
    @completed_time = Time.now

    # set user object
    @user = User.find(@user_id)
    @team = Team.find(@team_id)
    # date fields for further calculation
    # @current_datetime = params[:datetime_today] #Time.now # ==> FOR TESTING REASONS, SUPPLY THE CURRENT DATE
    @current_datetime = Time.now
    @current_day = @current_datetime.day
    @current_month = @current_datetime.month
    @current_year = @current_datetime.year

    # set today datetime objects (set @start_of_today, @end_of_today)
    set_today_start_end_datetime_objects

    if @team.nil? || @user.nil? || (@survey_type != 'Daily Wellness' && @survey_type != 'Post-Practice')
      return nil
    end

    @season = (@team.season).to_s.capitalize + '-' + (Time.now.year).to_s

    # if a daily-wellness, set appropriate fields to nil, and set data fields
    if (@survey_type == 'Daily Wellness')
      set_daily_wellness_survey(params)

    # if a post-practice, set appropriate fields to nil, and set data fields
    # elsif (@survey_type == 'Post-Practice')
    else
        print("post practice survey stuff")
        print(params)
      if Practice.find(@practice_id).nil? || !validate_fields_for_calculations(params)
        print("sadness. it's nil :(")
        return nil
      end
    #   if Practice.find(@practice_id).nil?
    #     print("sadness. it's nil :(")
    #     return nil
    #   end
      set_post_practice_survey(params)

    end
  end


  def get_survey_object
    @survey = Survey.new
    @survey.user = @user
    @survey.survey_type = @survey_type
    @survey.completed_time = @completed_time
    @survey.season = @season
    @survey.session_load = @session_load
    @survey.daily_load = @daily_load
    @survey.daily_strain = @daily_strain
    @survey.hours_of_sleep = @hours_of_sleep
    @survey.quality_of_sleep = @quality_of_sleep

    @survey.academic_stress = @academic_stress
    @survey.life_stress = @life_stress
    @survey.soreness = @soreness
    @survey.ounces_of_water_consumed = @ounces_of_water_consumed
    @survey.hydration_quality = @hydration_quality
    @survey.player_rpe_rating = @player_rpe_rating
    @survey.player_personal_performance = @player_personal_performance
    @survey.participated_in_full_practice = @participated_in_full_practice
    @survey.minutes_participated = @minutes_participated
    @survey.expected_session_load = @expected_session_load
    @survey.practice = @practice
    @survey.weekly_strain = @weekly_strain
    @survey.weekly_load = @weekly_load
    @survey.acute_load = @acute_load
    @survey.chronic_load = @chronic_load

    @survey.a_c_ratio = @a_c_ratio

    @survey.week_to_week_weekly_load_percent_change = @week_to_week_weekly_load_percent_change

    @survey.freshness_index = @freshness_index
    @survey.monotony = @monotony
    @survey.save!
    return @survey
  end

  # set survey fields

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
    @freshness_index = nil
    @week_to_week_weekly_load_percent_change = nil

    @practice_id = nil
  end

  def set_post_practice_survey(params)
    # for post practices, we have a practice object
    @practice = Practice.find(@practice_id)

    # set proper fields
    @player_rpe_rating = params[:player_rpe_rating].to_i
    @player_personal_performance = params[:player_personal_performance].to_i
    @participated_in_full_practice = params[:participated_in_full_practice] == "true" ? true : false

    if @participated_in_full_practice == true
      @minutes_participated = @practice.duration.to_i
    else
      @minutes_participated = params[:minutes_participated].to_i
    end

    @session_load = set_player_session_load
    @expected_session_load = set_expected_session_load
    @daily_load = set_daily_load.to_i
    @weekly_load = set_weekly_load
    @acute_load = set_acute_load
    @chronic_load = set_chronic_load
    @freshness_index = set_freshness_index

    @week_to_week_weekly_load_percent_change = set_week_to_week_weekly_load_percent_change

    @a_c_ratio = set_a_c_ratio
    @monotony = set_monotony

    @daily_strain = set_daily_strain
    @weekly_strain = set_weekly_strain

    # set all other fields to nil
    @hours_of_sleep = nil
    @quality_of_sleep = nil
    @academic_stress = nil
    @life_stress = nil
    @soreness = nil
    @ounces_of_water_consumed = nil
    @hydration_quality = nil

  end

  # set field functions

  # get the player session load based on current survey's rpe and duration practiced
  def set_player_session_load
    player_session_load = @player_rpe_rating * @minutes_participated
    return player_session_load
  end

  # get the expected session load for the associated practice for the survey
  def set_expected_session_load
    expected_session_load = @practice.duration * @practice.difficulty
    return expected_session_load
  end

  # get daily load by summing all of the session loads for today
  #     ASSUMPTION THAT WE CAN ONLY SUBMIT SURVEYS FOR THE CURRENT DAY
  def set_daily_load
    # need to fetch all of the practices for the current day of the practice
    sum_daily_load = 0 + @session_load # include session load of current survey
    surveys_today = Survey.for_user(@user_id).post_practice.surveys_on_date(@start_of_today, @end_of_today)
    # sum all surveys
    surveys_today.each do |survey|
      if survey.session_load.nil?
        return
      else
        sum_daily_load += survey.session_load
      end
    end
    return sum_daily_load
  end

  # get weekly load by summing all of the session loads from the past 6 days + today
  def set_weekly_load
    sum_weekly_load = 0 + @daily_load
    # get all surveys from the past 6 days + today
    one_week_ago_start = @start_of_today - (6 * SECONDS_IN_ONE_DAY)
    surveys_this_week = Survey.for_user(@user_id).post_practice.surveys_for_week(one_week_ago_start, @end_of_today)
    # sum all surveys
    surveys_this_week.each do |survey|
      if survey.session_load.nil?
        return
      else
        sum_weekly_load += survey.session_load
      end
    end
    return sum_weekly_load
  end

  # set the acute load (acute load = weekly load)
  def set_acute_load
    return @weekly_load
  end

  # set the chronic load, the average weekly_load over the previous 4 weeks
  #       need to calculate all weekly loads individually, can't access from anywhere in db
  def set_chronic_load
    # initialize for mean calculation
    array_of_weekly_loads = []
    # this week time range
    this_week_end = @end_of_today
    this_week_start = @start_of_today.ago(86400 * 6) # not necessary to have, don't use for weekly load calculation here
                                                     # since we already calculated it already (Also and edge, to incude the current survey)
    weekly_load_this_week = @weekly_load
    array_of_weekly_loads << weekly_load_this_week

    # last week time range
    one_week_ago_end = @end_of_today.ago(86400 * 7)
    one_week_ago_start = @start_of_today.ago(86400 * 13)
    weekly_load_one_week_ago = calculate_weekly_load_with_dates(one_week_ago_start, one_week_ago_end)
    array_of_weekly_loads << weekly_load_one_week_ago

    # two weeks ago time range
    two_weeks_ago_end = @end_of_today.ago(86400 * 14)
    two_weeks_ago_start = @start_of_today.ago(86400 * 20)
    weekly_load_two_weeks_ago = calculate_weekly_load_with_dates(two_weeks_ago_start, two_weeks_ago_end)
    array_of_weekly_loads << weekly_load_two_weeks_ago

    # three weeks ago time range
    three_weeks_ago_end = @end_of_today.ago(86400 * 21)
    three_weeks_ago_start = @start_of_today.ago(86400 * 27)
    weekly_load_three_weeks_ago = calculate_weekly_load_with_dates(three_weeks_ago_start,three_weeks_ago_end)
    array_of_weekly_loads << weekly_load_three_weeks_ago

    # get average of all weekly loads from past 4 weeks
    chronic_load = array_of_weekly_loads.mean

    return chronic_load
  end

  # set the freshness index, chronic load - acute load (difference in fitness + fatigue)
  def set_freshness_index
    freshness_index = @chronic_load - @acute_load
    return freshness_index
  end

  # set the Acute:Chronic Worload Ratio (ACWR), Acute / Chronic
  def set_a_c_ratio
    # divide by zero possibility => must check what to do with this edge case
    if @chronic_load == 0
      return 0
    else
      a_c_ratio = @acute_load / @chronic_load
      return a_c_ratio
    end
  end

  # set the monotony for the past week (6 days ago thru today) (mean / std. dev.)
  def set_monotony
    # get the beginning of the week
    one_week_ago_start = @start_of_today - (6 * SECONDS_IN_ONE_DAY)
    # get all of the daily loads from the past 6 days + today
    weeks_daily_loads = Survey.for_user(@user_id).post_practice.surveys_for_week(one_week_ago_start, @end_of_today)

    # create an array of all the daily loads
    week_daily_loads = get_week_daily_loads(weeks_daily_loads)

    # get mean of the daily loads from the last week
    mean_daily_loads = week_daily_loads.mean

    # get standard deviation of daily loads from last week
    standard_deviation_daily_loads = week_daily_loads.standard_deviation

    # divide by zero possibility => must check what to do with this edge case
    if standard_deviation_daily_loads == 0
      monotony = 0
    else
      # monotony = mean of daily lodas / standard deviation
      monotony = mean_daily_loads / standard_deviation_daily_loads
    end

    return monotony
  end

  # set the daily strain for today, daily_load * monotony
  def set_daily_strain
    daily_strain = @daily_load * @monotony
    return daily_strain
  end

  # set the weekly strain for this week, weekly_load * monotony
  def set_weekly_strain
    weekly_strain = @weekly_load * @monotony
    return weekly_strain
  end

  # set the week to week percent change in weekly load, get last week + this week's weekly load, compare percent change
  def set_week_to_week_weekly_load_percent_change
    # weekly load this week
    this_weeks_weekly_load = @weekly_load
    # weekly load last week
    last_week_end = @end_of_today.ago(86400 * 7)
    last_week_start = @start_of_today.ago(86400 * 13)
    last_weeks_weekly_load = calculate_weekly_load_with_dates(last_week_start, last_week_end)

    # divide by zero possibility => must check what to do with this edge case, set to 1
    if last_weeks_weekly_load == 0
      percent_change = 100
    else
      # percent change = ((y2 - y1) / y1)*100, y1=original-last & y2=new value-this
      percent_change = ((last_weeks_weekly_load - this_weeks_weekly_load) / last_weeks_weekly_load) * 100
    end

    return percent_change
  end

  # Validations

  # validate fields for post practice calcualtions
  def validate_fields_for_calculations(params)
    rpe = params[:player_rpe_rating].to_i
    performance = params[:player_personal_performance].to_i
    full_practice = params[:participated_in_full_practice]
    minutes = params[:minutes_participated].to_i
    # nill checks
    if rpe.nil? || performance.nil? || full_practice.nil?
      puts 1
      return false

    elsif minutes.nil? && validate_boolean_type(full_practice) && full_practice == false
      puts 2.5
      return false

    # type checks
    elsif (!validate_integer_type(rpe) || !validate_integer_type(performance) || !validate_boolean_type(full_practice))
      puts "here"

      return false
    # practice + minutes check
    elsif (full_practice == false && minutes.nil?)
        puts 3
      return false
    # pass preliminary checks
    else
        puts 4
      return true
    end

  end

  # validate whether a provided field is a boolean type
  def validate_boolean_type(field)
    puts field
    puts field.class
    if field == "1"
        field = true
    elsif field == "0"
        field = false
    end
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

  # Miscellaneous functions

  def set_today_start_end_datetime_objects
    if @current_datetime.dst?
      @start_of_today = Time.new(@current_year, @current_month, @current_day, 0, 0, 0, "-04:00")
      @end_of_today = Time.new(@current_year, @current_month, @current_day, 23, 59, 59, "-04:00")
    else
      @start_of_today = Time.new(@current_year, @current_month, @current_day, 0, 0, 0, "-05:00")
      @end_of_today = Time.new(@current_year, @current_month, @current_day, 23, 59, 59, "-05:00")
    end
  end

  # calculate weekly load given the start and end of the week
  def calculate_weekly_load_with_dates(startTime,endTime)
    sum_weekly_load = 0
    surveys_this_week = Survey.for_user(@user_id).post_practice.surveys_for_week(startTime, endTime)
    # sum all surveys
    surveys_this_week.each do |survey|
      if survey.session_load.nil?
        return
      else
        sum_weekly_load += survey.session_load
      end
    end
    # return the totaled
    return sum_weekly_load
  end

  # get array of daily loads of every day (no repeats)
  def get_week_daily_loads(weeks_surveys)
    daily_hash = {monday: 0, tuesday:0, wednesday:0, thursday:0, friday:0, saturday:0, sunday:0}

    # weeks_surveys.each do |survey|
    #   survey_day_key = get_day_of_week(survey.completed_time)
    # puts '- - - - - - - - - - - - - - - - - - - - - - - - '
    # puts daily_hash[:monday]
    # puts '- - - - - - - - - - - - - - - - - - - - - - - - '
    #   daily_hash[survey_day_key] += survey.session_load
    # end
    weeks_surveys.each do |survey|
      survey_datetime = survey.practice.practice_time
      if survey_datetime.monday?
        daily_hash[:monday] += survey.session_load
      elsif survey_datetime.tuesday?
        daily_hash[:tuesday] += survey.session_load
      elsif survey_datetime.wednesday?
        daily_hash[:wednesday] += survey.session_load
      elsif survey_datetime.thursday?
        daily_hash[:thursday] += survey.session_load
      elsif survey_datetime.friday?
        daily_hash[:friday] += survey.session_load
      elsif survey_datetime.saturday?
        daily_hash[:saturday] += survey.session_load
      # elsif current_day.sunday?
      else
        daily_hash[:sunday] += survey.session_load
      end
    end
    return daily_hash.values
  end

  # return the day of the week, given the datetime
  def get_day_of_week(survey_datetime)
    if survey_datetime.monday?
      day_of_week = "Monday"
    elsif survey_datetime.tuesday?
      day_of_week = "Tuesday"
    elsif survey_datetime.wednesday?
      day_of_week = "Wednesday"
    elsif survey_datetime.thursday?
      day_of_week = "Thursday"
    elsif survey_datetime.friday?
      day_of_week = "Friday"
    elsif survey_datetime.saturday?
      day_of_week = "Saturday"
    # elsif current_day.sunday?
    else
      day_of_week = "Sunday"
    end

    return day_of_week
  end


end
