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









end
