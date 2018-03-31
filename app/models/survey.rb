class Survey < ApplicationRecord
    # callbacks
    before_validation :convert_season

    # Require the JSON gem for parseStringToJSON method
    require 'json'

    # Array constants
    SURVEY_TYPES = [['Daily Wellness', :daily_wellness], ['Post-Practice', :post_practice]]

    # Class Variables
    @@current_seasons = self.calculate_current_seasons

    # Relationships
    belongs_to :user

    # Scopes

    # Validations
    validates_presence_of :type, :response, :completed
    validates_presence_of :season, message: "is not a valid season for this survey"
    validates_inclusion_of :type, in: SURVEY_TYPES.map{|key, value| value}, message: "is not a valid survey type"
    validates_date :completed, on_or_before: lambda { Date.current }
    validate :response_proper_format

    # Methods

    # For turning the response string to a JSON object
    def parseStringToJSON
        JSON.parse(self.response)
    end

    private

    # format the season to conform with our Season-Year format (validates date as well, wont take anything once it is nil)
    def convert_season
      if !(self.season.nil?)
        season = self.season
        if season != 'Fall' || season != 'Winter' || seson != 'Spring'
          self.completed = nil
          return
        else
          current_year = Time.now.year
          self.season = season + current_year.to_s
          return
        end
    end

    def response_proper_format
        if self.response.match(/{.+}/).nil?
            return false
        end
        true
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
