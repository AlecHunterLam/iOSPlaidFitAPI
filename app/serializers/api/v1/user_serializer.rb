module Api::V1
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :first_name, :last_name, :andrew_id, :email, :major, :phone, :role, :active, :table_survey_objects,
               :missing_post_boolean, :missing_daily_boolean, :missing_both_boolean
    has_many :player_calculations
    # has_many :surveys
    has_many :events
    has_many :earned_badges
    has_many :notifications
    has_many :team_assignments

    def table_survey_objects
      object.surveys.daily_wellness.map do |survey|
        SurveySerializer.new(survey)
      end
    end

    def missing_post_boolean

    end

    def missing_daily_boolean

    end

    def missing_both_boolean
      
    end


  end
end
