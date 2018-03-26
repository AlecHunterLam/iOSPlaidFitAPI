class AddWeeklyStrainToPlayerCalculations < ActiveRecord::Migration[5.1]
  def change
    add_column :player_calculations, :weekly_strain, :float
  end
end
