class AddPlayerAndTeamCalculationFields < ActiveRecord::Migration[5.1]
  def change
    # team calculations
    remove_column :team_calculations, :sleep_average
    add_column :team_calculations, :sleep_amount_average, :float
    remove_column :team_calculations, :hydration_average
    add_column :team_calculations, :hydration_amount_average, :float
    # removing soreness for now
    remove_column :team_calculations, :soreness_average
    rename_column :team_calculations, :load_average, :daily_load_average

    # player calculations
    remove_column :player_calculations, :sleep_average
    add_column :player_calculations, :sleep_amount_average, :float
    remove_column :player_calculations, :hydration_average
    add_column :player_calculations, :hydration_amount_average, :float
    # removing soreness for now
    remove_column :player_calculations, :soreness_average
    rename_column :player_calculations, :load_average, :daily_load_average

  end
end
