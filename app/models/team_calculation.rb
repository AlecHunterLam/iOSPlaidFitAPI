class TeamCalculation < ApplicationRecord

    # Array constants
    SEASONS = [['Fall', :fall], ['Winter', :winter], ['Spring', :spring]]

    # Relationships
    belongs_to :team

    # Scopes
    scope :for_team,   -> (team_id) { where(team_id: team_id) }
    scope :for_season,   -> (season) { where(season: season) }

    # Validations
    validates_presence_of :team_id, :week_of
    validates_date :week_of
    validate :validate_season
    validate :validate_week_of
    # Need stats validations

    # Methods

    private

    # Makes sure that the week_of variable starts on a Monday
    def validate_week_of
      input_week_of = self.week_of
      # correct day, assuming input week is a Time object
      # http://ruby-doc.org/core-2.2.0/Time.html#method-i-sunday-3F
      return input_week_of.monday?
    end


    def validate_season
      input_season = self.season
      # correct format
      test_regex = /^(Fall|Winter|Spring)-20([0-9]{2})$/
      return test_regex.match(input_season)
    end

end
