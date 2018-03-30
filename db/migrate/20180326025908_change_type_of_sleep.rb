class ChangeTypeOfSleep < ActiveRecord::Migration[5.1]
  def change
    add_column :team_calculations, :sleep_average, :float
  end
end
