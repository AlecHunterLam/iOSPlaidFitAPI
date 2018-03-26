class AddWeeklyLoadToPlayerAndTeamCalculations < ActiveRecord::Migration[5.1]
  def change
    add_column :player_calculations, :weekly_load, :float 
    add_column :team_calculations, :weekly_load, :float
  end
end
