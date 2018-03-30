class RemoveFieldsForTeamCalculations < ActiveRecord::Migration[5.1]
  def change
    remove_column :team_calculations, :sleep
    remove_column :team_calculations, :hydration
    remove_column :team_calculations, :stress
    remove_column :team_calculations, :load
  end
end
