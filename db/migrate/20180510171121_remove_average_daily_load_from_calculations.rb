class RemoveAverageDailyLoadFromCalculations < ActiveRecord::Migration[5.1]
  def change
    remove_column :team_calculations, :daily_load_average
    remove_column :player_calculations, :daily_load_average
  end
end
