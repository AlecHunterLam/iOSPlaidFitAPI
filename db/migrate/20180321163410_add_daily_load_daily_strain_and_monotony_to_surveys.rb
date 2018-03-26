class AddDailyLoadDailyStrainAndMonotonyToSurveys < ActiveRecord::Migration[5.1]
  def change
    add_column :surveys, :daily_load, :float
    add_column :surveys, :daily_strain, :float
    add_column :surveys, :monotony, :float
  end
end
