# calculated at the end of each week (monday-monday) for each player
# run the cron job sunday night
require 'descriptive_statistics'

SECONDS_IN_ONE_DAY = 86400

class SurveyService
  def initialize(params)
    @user_id = params[:user_id]
    @survey_type = params[:survey_type]
    @team_id = params[:team_id]
    @practice_id = params[:practice_id]

    @hours_of_sleep = params[:hours_of_sleep]
    @quality_of_sleep = params[:quality_of_sleep]
    @academic_stress = params[:academic_stress]
    @life_stress = params[:life_stress]
    @soreness = params[:soreness]
    @ounces_of_water_consumed = params[:ounces_of_water_consumed]
    @hydration_quality = params[:hydration_quality]
    @player_rpe_rating = params[:player_rpe_rating]
    @player_personal_performance = params[:player_personal_performance]
    @participated_in_full_practice = params[:participated_in_full_practice]
    @minutes_participated = params[:minutes_participated]

    @completed_time = Time.now

    @season = (Team.find(@team_id).season).to_s + (Time.now.year).to_s

    @session_load = nil
    @daily_load = nil
    @monotony = nil
    @daily_strain = nil


    # set the fields
    @player_calculation.user_id = @user_id
  end

  def get_survey_from_reponse
    @survey = Survey.new
    set_provided_survey_params
  end


  def set_provided_survey_params
    @survey.user_id = @user_id
    @survey.type = @survey_type
    @survey.completed_time = @completed_time

    @survey.hours_of_sleep = @hours_of_sleep
    @survey.quality_of_sleep = @quality_of_sleep
    @survey.academic_stress = @academic_stress
    @survey.life_stress = @life_stress
    @survey.soreness = @soreness
    @survey.ounces_of_water_consumed = @ounces_of_water_consumed
    @survey.hydration_quality = @hydration_quality
    @survey.player_rpe_rating = @player_rpe_rating
    @survey.player_personal_performance = @player_personal_performance
    @survey.minutes_participated = @minutes_participated

    perform_survey_calculations

  end

  def perform_survey_calculations
    # set the season for the survey
    players_team = Team.find(@team_id)
    season = players_team.season.capitalize
    @survey.season = season + '-' + (Time.now.year).to_s

    # if daily wellness, return => dont need any of the following information
    if @survey.survey_type.nil? || @survey.survey_type == :daily_wellness
      return @survey
    end

    # Session Load => need to calculate session load based on how much the player played, and the difficulty they perceived
    @survey.session_load = @minutes_participated * @player_rpe_rating

    # Expected Session Load => need to calculate based on practice for that day
    @survey.expected_session_load = Practice.find(@practice_id).session_load

    # get the practices for the current day
    current_day = (Time.now.day).to_s
    current_year = (Time.now.year).to_s
    current_month = (Time.now.month).to_s
    # daylights saving case
    if Time.now.dst?
      start_day_time = Time.new(current_year, current_month, current_day, 0, 0, 0, "-04:00")
      end_day_time = Time.new(current_year, current_month, current_day, 23, 59, 59, "-04:00")
    # not-daylights saving case
    else
      start_day_time = Time.new(current_year, current_month, current_day, 0, 0, 0, "-05:00")
      end_day_time = Time.new(current_year, current_month, current_day, 23, 59, 59, "-05:00")
    end

    # Daily Load => ASSUMPTION THAT WE CAN ONLY SUBMIT SURVEYS FOR THE CURRENT DAY

    # can yield multiple practices if multiple practices on a current day
    post_surveys_for_today = Survey.for_user(@user_id).post_practice.surveys_on_date(start_day_time,end_day_time)

    sum_of_loads_for_today = 0
    sum_of_loads_for_today += @survey.session_load

    if !(post_surveys_for_today.nil?)
      post_surveys_for_today.each do |p|
        sum_of_loads_for_today += p.session_load
      end
    end

    @survey.daily_load = sum_of_loads_for_today


    # Monotony =>
    #  user daily_load as the sample

    # sum all daily loads up until this point, if there are two, take the latest daily load
    post_surveys_up_until_now = Survey.for_user(@user_id).post_practice.surveys_for_week(start_of_week)


    day_hash = {"Monday":0, "Tuesday":0, "Wednesday":0, "Thursday":0, "Friday":0, "Saturday":0, "Sunday":0}
    single_practice_per_day = post_surveys_up_until_now.filter{ |survey|
                                                if survey.practice.practice_time.monday?
                                                  if day_hash["Monday"] != 0
                                                    day_hash["Monday"] += 1
                                                    return true
                                                  else
                                                    return false
                                                  end
                                                elsif survey.practice.practice_time.tuesday?
                                                  if day_hash["Tuesday"] != 0
                                                    day_hash["Tuesday"] += 1
                                                    return true
                                                  else
                                                    return false
                                                  end
                                                elsif survey.practice.practice_time.wednesday?
                                                  if day_hash["Wednesday"] != 0
                                                    day_hash["Wednesday"] += 1
                                                    return true
                                                  else
                                                    return false
                                                  end
                                                elsif survey.practice.practice_time.thursday?
                                                  if day_hash["Thursday"] != 0
                                                    day_hash["Thursday"] += 1
                                                    return true
                                                  else
                                                    return false
                                                  end
                                                elsif survey.practice.practice_time.friday?
                                                  if day_hash["Friday"] != 0
                                                    day_hash["Friday"] += 1
                                                    return true
                                                  else
                                                    return false
                                                  end
                                                elsif survey.practice.practice_time.saturday?
                                                  if day_hash["Saturday"] != 0
                                                    day_hash["Saturday"] += 1
                                                    return true
                                                  else
                                                    return false
                                                  end
                                                # elsif survey.practice.practice_time.sunday?
                                                else
                                                  if day_hash["Sunday"] != 0
                                                    day_hash["Sunday"] += 1
                                                    return true
                                                  else
                                                    return false
                                                  end
                                                end

                                              }




    sum_of_loads_all_days = 0 + @daily_load
    single_practice_per_day.each { |survey| sum_of_loads_all_days += survey.daily_load }

    single_practice_per_day.map! { |survey| survey.daily_load }

    # sum up until this point, including today (mean)
    result_numerator = single_practice_per_day.sum  / (denominator_for_day)

    # standard deviation
    result_denominator = single_practice_per_day.standard_deviation

    @monotony = (result_numerator / result_denominator)

    @survey.monotony = @monotony

    # Daily strain (daily load * monotony)
    @survey.daily_strain = @monotony * @daily_load

    return @survey
  end


  def denominator_for_day
    today = Time.now
    if today.monday?
      return 1
    elsif today.tuesday?
      return 2
    elsif today.wednesday?
      return 3
    elsif today.thursday?
      return 4
    elsif today.friday?
      return 5
    elsif today.saturday?
      return 6
    # elsif current_day.sunday?
    else
      return 7
    end
  end




  # Step 1: Find the mean.
  # Step 2: For each data point, find the square of its distance to the mean.
  # Step 3: Sum the values from Step 2.
  # Step 4: Divide by the number of data points.
  # Step 5: Take the square root.

  def calculate_standard_deviation_of_loads_in_week
    # given an arbitrary date, we need to get the start of the week, and end of the week dates
    current_day = (Time.now.day).to_s
    current_year = (Time.now.year).to_s
    current_month = (Time.now.month).to_s

    default_start = Time.new(current_year, current_month, current_day, 0, 0, 0, "-05:00")
    default_end   = Time.new(current_year, current_month, current_day, 23, 59, 59, "-05:00")

    day_of_week_offset = get_day_of_week_offset

    start_of_week = default_start - (day_of_week_offset * SECONDS_IN_ONE_DAY)
    end_of_week = default_end + ((6 - day_of_week_offset) * SECONDS_IN_ONE_DAY)

    # 1: calculate the mean up to this point
    surveys_for_this_week = Survey.surveys_for_week(start_of_week,end_of_week)
    # need to filter out multiple practices for one day => take the latest submitted survey, take the most recent

    # ... still continuing
  end



  def get_day_of_week_offset
    current_day = Time.now
    day_of_week = nil
    if current_day.monday?
      day_of_week = 0
    elsif current_day.tuesday?
      day_of_week = 1
    elsif current_day.wednesday?
      day_of_week = 2
    elsif current_day.thursday?
      day_of_week = 3
    elsif current_day.friday?
      day_of_week = 4
    elsif current_day.saturday?
      day_of_week = 5
    # elsif current_day.sunday?
    else
      day_of_week = 6
    end
  end

  create_table "surveys", force: :cascade do |t|
    t.integer "user_id"        done
    t.string "survey_type"       done
    t.datetime "completed_time"  done

    t.string "season"            done
    t.float "session_load"       done
    t.float "expected_session_load"  done
    t.float "daily_load"             done
    t.float "daily_strain"
    t.float "monotony"               done

    t.float "hours_of_sleep"    done
    t.integer "quality_of_sleep"done
    t.integer "academic_stress" done
    t.integer "life_stress"     done
    t.integer "soreness"        done
    t.float "ounces_of_water_consumed"  done
    t.boolean "hydration_quality"       done
    t.integer "player_rpe_rating"       done
    t.integer "player_personal_performance"   done
    t.boolean "participated_in_full_practice" done
    t.integer "minutes_participated"          done
  end

  private


end
