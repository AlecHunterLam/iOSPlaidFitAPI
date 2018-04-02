class FixStressFieldsForPlayerAndTeamCalculations < ActiveRecord::Migration[5.1]
  def change
    remove_column :player_calculations, :stress_average
    remove_column :team_calculations, :stress_average

    add_column :player_calculations, :life_stress_average, :float
    add_column :player_calculations, :academic_stress_average, :float

    add_column :team_calculations, :life_stress_average, :float
    add_column :team_calculations, :academic_stress_average, :float
  end
end
