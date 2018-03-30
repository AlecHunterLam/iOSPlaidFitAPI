class AddQualityOfSleepAndHydrationQualityFields < ActiveRecord::Migration[5.1]
  def change
    add_column :player_calculations, :sleep_quality_average, :float
    add_column :player_calculations, :hydration_quality_average, :float


    add_column :team_calculations, :sleep_quality_average, :float
    add_column :team_calculations, :hydration_quality_average, :float

  end
end
