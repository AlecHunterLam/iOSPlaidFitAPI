# calculated at the end of each week (monday-monday) for each player
# run the cron job sunday night

class SurveyService
  def initialize(params)
    @player_id = params[:player_id]
    @survey_type = params[:survey_type]
    @team_id = params[:team_id]
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
    @player_calculation.player_id = @user_id
  end

  def get_survey_from_reponse
    @survey = Survey.new
    set_provided_survey_params
  end


  def set_provided_survey_params
    @survey.player_id = @player_id
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
    # calculate session load
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
    # can yield multiple practices if multiple practices on a current day
    practices_today = Practice.practice_on_date(start_day_time, end_day_time)

    # need to calculate session load based on how much the player played, and the difficulty
    @survey.session_load = @

    # session load =

  end

  create_table "surveys", force: :cascade do |t|
    t.integer "player_id"        done
    t.string "survey_type"       done
    t.datetime "completed_time"  done
    t.string "season"            done
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "session_load"
    t.float "daily_load"
    t.float "daily_strain"
    t.float "monotony"
    t.float "hours_of_sleep"    done
    t.integer "quality_of_sleep"
    t.integer "academic_stress"
    t.integer "life_stress"
    t.integer "soreness"
    t.float "ounces_of_water_consumed"
    t.boolean "hydration_quality"
    t.integer "player_rpe_rating"
    t.integer "player_personal_performance"
    t.boolean "participated_in_full_practice"
    t.integer "minutes_participated"
  end

  private


end
