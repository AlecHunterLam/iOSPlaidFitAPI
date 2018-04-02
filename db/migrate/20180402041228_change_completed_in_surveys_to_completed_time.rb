class ChangeCompletedInSurveysToCompletedTime < ActiveRecord::Migration[5.1]
  def change
    rename_column :surveys, :completed, :completed_time
  end
end
