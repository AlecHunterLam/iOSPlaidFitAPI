class Survey < ApplicationRecord

    # Require the JSON gem for parseStringToJSON method
    require 'json'

    # Array constants
    SURVEY_TYPES = [['Daily Wellness', :daily_wellness], ['Post-Practice', :post_practice]]
    SEASONS = [['Fall', :fall], ['Winter', :winter], ['Spring', :spring]]

    # Relationships
    belongs_to :user

    # Scopes

    # Validations
    validates_presence_of :type, :response, :completed, :season
    validates_inclusion_of :type, in: SURVEY_TYPES.map{|key, value| value}, message: "is not a valid survey type"
    validates_inclusion_of :season, in: SEASONS.map{|key, value| value}, message: "is not a valid season"
    validates_date :completed, on_or_before: lambda { Date.current }
    validate :response_proper_format

    # Methods

    # For turning the response string to a JSON object
    def parseStringToJSON
        JSON.parse(self.response)
    end

    private

    def response_proper_format
        if self.response.match(/{.+}/).nil?
            return false
        end
        true
    end
    
end
