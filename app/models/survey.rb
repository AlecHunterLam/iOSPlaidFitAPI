class Survey < ApplicationRecord
    # callbacks
    before_save :type_survey_fields_nil

    # Array constants
    SURVEY_TYPES = [['Daily Wellness', :daily_wellness], ['Post-Practice', :post_practice]]


    # Relationships
    belongs_to :user
    belongs_to :practice, optional: true

    # Scopes
    scope :surveys_on_date,  (startTime,endTime)          -> { where("completed_time BETWEEN startTime AND endTime") }
    scope :for_user,         (user_id)                    -> { where("player_id == ?", user_id) }
    scope :daily_wellness,                                -> { where("survey_type == daily_wellness") }
    scope :post_practice,                                -> { where("survey_type == post_practice") }
    scope :surveys_for_week,  (startWeek,endWeek)        -> { where("completed_time BETWEEN startTime AND endTime") }

    # Validations
    validates_presence_of :survey_type, :completed
    validates_presence_of :season, message: "is not a valid season for this survey"
    validates_inclusion_of :type, in: SURVEY_TYPES.map{|key, value| value}, message: "is not a valid survey type"
    validates_date :completed, on_or_before: Time.now

    validate :validate_season

    validate :validate_daily_wellness
    validate :validate_post_practice

    # if daily wellness survey, need to have all answers for the wellness portion
    def validate_daily_wellness
      if self.survey_type == :post_practice
        return true
      elsif self.survey_type == :daily_wellness
        # check that all fields are not nil, since we are in daily wellness
        if !(self.hours_of_sleep.nil?) && (self.quality_of_sleep.nil?) && !(self.academic_stress.nil?) && !(self.life_stress.nil?) && !(self.soreness.nil?) && !(self.ounces_of_water_consumed.nil?) && !(self.hydration_quality.nil?)
          # validate the types of all of the fields, and that all are above 0
          if validate_sleep_field(self.hours_of_sleep) && validate_categorical_field(self.quality_of_sleep) && validate_categorical_field(self.academic_stress) && validate_categorical_field(self.life_stress) && validate_categorical_field(self.soreness) && validate_water_field(self.ounces_of_water_consumed) && validate_boolean_type(self.hydration_quality)
            return true
          else
            return false
          end
        else
          return false
        end
      else
        return false
      end
    end

    # if post practice survey, need to have all answers for the wellness portion
    def validate_post_practice
      if self.survey_type == :daily_wellness
        return true
      elsif self.survey_type == :post_practice
        # check that all fields are not nil, since we are in post practice
        if !(self.player_rpe_rating.nil?) && (self.player_personal_performance.nil?) && !(self.player_personal_performance.nil?) && !(self.participated_in_full_practice.nil?) && !(self.minutes_participated.nil?)
          # validate the types of all of the fields, and that all are above 0
          if validate_rpe_field(self.player_rpe_rating) && validate_personal_performance(self.player_personal_performance) && validate_boolean_type(self.participated_in_full_practice.nil?) && validate_minutes_participated(self.minutes_participated)
            return true
          else
            return false
          end
        else
          return false
        end
      else
        return false
      end
    end

    # after validating, set all inactive fields to false based on the type of the survey
    def type_survey_fields_nil
      if self.survey_type == :daily_wellness
        self.player_rpe_rating = nil
        self.player_personal_performance = nil
        self.participated_in_full_practice = nil
        self.minutes_participated = nil
      # post practice case
      else
        self.hours_of_sleep = nil
        self.quality_of_sleep = nil
        self.academic_stress = nil
        self.life_stress = nil
        self.soreness = nil
        self.ounces_of_water_consumed = nil
        self.hydration_quality = nil
      end
    end



    # Methods
    private

    def validate_sleep_field(field)
      return validate_float_type(field) && field >= 0 && field <= 12
    end

    def validate_categorical_field(field)
      return validate_integer_type(field) && field >= 0 && field <= 5
    end

    def validate_water_field(field)
      return validate_float_type(field) && field >= 0 && field <= 128
    end

    def validate_minutes_participated(field)
      return validate_integer_type(field) && field >= 0 && field <= 240
    end

    def validate_rpe_field(field)
      return validate_integer_type(field) && field >= 0 && field <= 10
    end

    def validate_personal_performance(field)
      return validate_integer_type(field) && field >= 1 && field <= 10
    end

    # validate whether a provided field is a boolean type
    def validate_boolean_type(field)
      if field.is_a?(TrueClass) || field.is_a?(FalseClass)
        return true
      else
        return false
      end
    end

    # validate integer type for provided field - MUST BE POSITIVE
    def validate_integer_type(field)
      if field.is_a?(Integer) && field >= 0
        return true
      else
        return false
      end
    end

    # validate float type for provided field - MUST BE POSITIVE
    def validate_float_type(field)
      if field.is_a?(Float) && field >= 0
        return true
      else
        return false
      end
    end

    def validate_season
      input_season = self.season
      # correct format
      test_regex = /^(Fall|Winter|Spring)-20([0-9]{2})$/
      return test_regex.match(input_season)
    end


    # build up current season strings
    # Season formatted as the following:
    #   => Fall-20**
    #   => Winter-20**
    #   => Spring-20**
    #   => Other-20** if our of range
    def calculate_current_seasons
      current_seasons = []
      current_month = Time.now.month
      current_year = Time.now.year
      current_year = current_year.to_s
      # Fall Season
      if 8 <= current_month && current_month <= 12
        current_seasons << ("Fall-" + current_year)
      end
      if 11 <= current_month || current_month <= 3
        current_seasons << ("Winter-" + current_year)
      end
      if 2 <= current_month && current_month <= 6
        current_seasons << ("Spring-" + current_year)
      end
      if current_seasons == []
        current_seasons << ("Other-" + current_year)
      end
      return current_seasons
    end

end
