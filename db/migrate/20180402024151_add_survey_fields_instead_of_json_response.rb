class AddSurveyFieldsInsteadOfJsonResponse < ActiveRecord::Migration[5.1]
  def change
    remove_column :surveys, :response

    # add column for all fields
    rename_column :surveys, :type, :survey_type

    # Daily Wellness
    add_column :surveys, :hours_of_sleep, :float
    add_column :surveys, :quality_of_sleep, :integer
    add_column :surveys, :academic_stress, :integer
    add_column :surveys, :life_stress, :integer
    add_column :surveys, :soreness, :integer
    add_column :surveys, :ounces_of_water_consumed, :float
    add_column :surveys, :hydration_quality, :boolean

    # Post Practice
    add_column :surveys, :player_rpe_rating, :integer
    add_column :surveys, :player_personal_performance, :integer
    add_column :surveys, :participated_in_full_practice, :boolean
    add_column :surveys, :minutes_participated, :integer
  end
end
