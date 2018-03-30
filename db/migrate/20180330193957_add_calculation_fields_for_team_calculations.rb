class AddCalculationFieldsForTeamCalculations < ActiveRecord::Migration[5.1]
  def change
    add_column :team_calculations, :hydration_average, :float
    add_column :team_calculations, :stress_average, :float
    add_column :team_calculations, :soreness_average, :float
    add_column :team_calculations, :load_average, :float
    add_column :team_calculations, :weekly_strain, :float
  end
end
