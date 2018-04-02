# calculated at the end of each week (monday-monday) for each player
# run the cron job sunday night
class SurveyService
  def initialize(params)
    @player_id = params[:player_id]
    @type = params[:survey_type]
    @response = params[:response]
    @team_id = params[:team_id]
    @completed = Time.now
    @season = (Team.find(@team_id).season).to_s + (Time.now.year).to_s
    @session_load = nil
    @daily_load = nil
    @monotony = nil
    @dailt_strain = nil

    @survey = Survey.new
    # set the fields
    @player_calculation.player_id = @user_id
  end


  def set_provided_survey_params
    @survey.player_id = @player_id
    @survey.type = @type
    @survey.response = @response
    @survey.completed = @completed
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
    t.integer "player_id" X
    t.string "type" X
    t.string "response" X
    t.datetime "completed" X
    t.string "season" X
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "session_load"
    t.float "daily_load"
    t.float "daily_strain"
    t.float "monotony"
  end

  private


end
