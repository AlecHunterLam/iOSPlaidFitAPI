# calculated at the end of each week (monday-monday) for each player
# run the cron job sunday night
class PlayerCalculationService
  def initialize(user_object)
    @user_id = user_object.id
    @player_calculation = PlayerCalculation.new

    # set the fields
    @player_calculation.user_id = @user_id
  end


  private
  def self.get_sleep_average
  end

  def self.get_hydration_average
  end

  def self.get_soreness_average
  end

  def self.get_load_average
  end

  def self.get__average
  end

  def self.get_sleep_average
  end
  create_table "player_calculations", force: :cascade do |t|
    t.integer "user_id"
    t.float "sleep_average"
    t.float "hydration_average"
    t.float "soreness_average"
    t.float "load_average"
    t.string "season"
    t.integer "season_rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "weekly_load"
    t.float "weekly_strain"
    t.float "life_stress_average"
    t.float "academic_stress_average"
    t.float "sleep_quality_average"
    t.float "hydration_quality_average"
    t.float "personal_performance_average"
    t.float "practice_difficulty_average"
    t.datetime "week_of"
  end









end
