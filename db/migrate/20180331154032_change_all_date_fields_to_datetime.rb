class ChangeAllDateFieldsToDatetime < ActiveRecord::Migration[5.1]
  def change
    remove_column :player_calculations, :weak_of
    add_column :player_calculations, :week_of, :datetime

    change_column :practices, :date, :datetime

    change_column :surveys, :completed, :datetime

    change_column :team_calculations, :week_of, :datetime
  end
end
