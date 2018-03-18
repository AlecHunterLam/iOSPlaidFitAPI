class TeamCalculation < ApplicationRecord

    # Array constants
    SEASONS = [['Fall', :fall], ['Winter', :winter], ['Spring', :spring]]

    # Relationships
    belongs_to :team

    # Scopes

    # Validations
    validates_presence_of :team_id, :week_of
    validates_date :week_of
    validates :sleep, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 24 }
    validates :hydration, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 200 }
    # need to change these ranges maybe, ask adam about ranges
    validates :stress, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }
    validates :load, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }
    validates_inclusion_of :season, in: SEASONS.map{|key, value| value}, message: "is not a valid sports season"
    validate :week_of_on_monday

    # Methods

    private

    # Makes sure that the week_of variable starts on a Monday
    def week_of_on_monday
        if self.week_of.strftime("%A") == "Monday"
            return true
        end
        false
    end

end
