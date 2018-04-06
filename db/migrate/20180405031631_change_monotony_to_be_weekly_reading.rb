class ChangeMonotonyToBeWeeklyReading < ActiveRecord::Migration[5.1]
  def change
    remove_column :surveys, :monotony

    # add monotony to weekly calculations
    add_column :player_calculations, :monotony, :float
    add_column :team_calculations, :team_monotony, :float

    # add week to week percent change
    add_column :player_calculations, :week_to_week_weekly_load_percent_change, :float
    add_column :team_calculations, :week_to_week_weekly_load_percent_change, :float

  end
end
