module Api::V1
  class UserSerializer < ActiveModel::Serializer


    attributes :id, :first_name, :last_name, :andrew_id, :email, :major, :phone, :role, :active, :daily_wellness_survey_today_objects,
               :missing_post_boolean, :missing_daily_boolean, :api_key, :post_practice_survey_yesterday_objects,
               :daily_wellness_survey_weekly_objects, post_practice_survey_weekly_objects #, :missing_both_boolean
    has_many :player_calculations
    # has_many :surveys
    has_many :events
    has_many :earned_badges
    has_many :notifications
    has_many :team_assignments

    def daily_wellness_survey_today_objects
      object.surveys.daily_wellness_serializer.surveys_today.map do |survey|
        SurveySerializer.new(survey)
      end
    end

    def post_practice_survey_yesterday_objects
      object.surveys.post_practice_serializer.surveys_yesterday.map do |survey|
        SurveySerializer.new(survey)
      end
    end

    def daily_wellness_survey_weekly_objects
      today = Time.now
      today_day = today.day
      today_month = today.month
      today_year = today.year

      start_week_day = today.ago(86400 * 6).day
      start_week_month = today.ago(86400 * 6).month
      start_week_year =today.ago(86400 * 6).year

      start_of_week = Time.new(start_week_year, start_week_month, start_week_day, 0, 0, 0, "-04:00")
      end_of_week = Time.new(today_year, today_month, today_day, 23, 59, 59, "-04:00")

      object.surveys.daily_wellness_serializer.surveys_for_week(start_of_week,end_of_week).map do |survey|
        SurveySerializer.new(survey)
      end
    end


    def post_practice_survey_weekly_objects
      today = Time.now
      today_day = today.day
      today_month = today.month
      today_year = today.year

      start_week_day = today.ago(86400 * 6).day
      start_week_month = today.ago(86400 * 6).month
      start_week_year =today.ago(86400 * 6).year

      start_of_week = Time.new(start_week_year, start_week_month, start_week_day, 0, 0, 0, "-04:00")
      end_of_week = Time.new(today_year, today_month, today_day, 23, 59, 59, "-04:00")

      object.surveys.post_practice_serializer.surveys_for_week(start_of_week,end_of_week).map do |survey|
        SurveySerializer.new(survey)
      end
    end



    def missing_post_boolean
      today = Time.now
      today_day = today.day
      today_month = today.month
      today_year = today.year
      start_of_today = Time.new(today_year, today_month, today_day, 0, 0, 0, "-04:00")
      end_of_today = Time.new(today_year, today_month, today_day, 23, 59, 59, "-04:00")

      if Survey.for_user(object.id).post_practice_serializer.surveys_on_date(start_of_today,end_of_today).empty?
        return true
      else
        return false
      end

    end

    def missing_daily_boolean
      today = Time.now
      today_day = today.day
      today_month = today.month
      today_year = today.year
      start_of_today = Time.new(today_year, today_month, today_day, 0, 0, 0, "-04:00")
      end_of_today = Time.new(today_year, today_month, today_day, 23, 59, 59, "-04:00")

      if Survey.for_user(object.id).daily_wellness_serializer.surveys_on_date(start_of_today,end_of_today).empty?
        return true
      else
        return false
      end
    end
    #
    # def missing_both_boolean
    #   return missing_daily_boolean && missing_post_boolean
    # end


  end
end
