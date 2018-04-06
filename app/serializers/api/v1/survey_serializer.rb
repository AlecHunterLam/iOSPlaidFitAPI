module Api::V1
  class SurveySerializer < ActiveModel::Serializer
    attributes :id, :user_id, :survey_type, :completed_time, :season, :session_load, :daily_load, :daily_strain, :hours_of_sleep, :quality_of_sleep, :academic_stress, :life_stress, :soreness, :ounces_of_water_consumed, :hydration_quality, :player_rpe_rating, :player_personal_performance, :participated_in_full_practice, :minutes_participated, :expected_session_load,
                :practice_id, :weekly_strain, :weekly_load, :acute_load, :chronic_load, :a_c_ratio, :week_to_week_weekly_load_percent_change,
                :freshness_index, :monotony
    belongs_to :user
    belongs_to :practice, optional: true
  end
end
