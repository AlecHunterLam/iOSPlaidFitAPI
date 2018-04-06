class AddWeeklyFieldsToSurvey < ActiveRecord::Migration[5.1]
  def change
    add_column :surveys, :weekly_strain, :float
    add_column :surveys, :weekly_load, :float
    add_column :surveys, :acute_load, :float
    add_column :surveys, :chronic_load, :float
    add_column :surveys, :a_c_ratio, :float
    add_column :surveys, :week_to_week_weekly_load_percent_change, :float
  end
end
