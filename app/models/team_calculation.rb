class TeamCalculation < ApplicationRecord

    # Array constants
    SEASONS = [['Fall', 'fall'], ['Winter', 'winter'], ['Spring', 'spring']]

    # Relationships
    belongs_to :team

    # Scopes

    # Validations
    validates_presence_of :team_id, :week_of
    validates_date :week_of
    validates :sleep, numericality: true
    validates :hydration, numericality: true
    validates :stress, numericality: true
    validates :load, numericality: true
    validates_inclusion_of :season, in: SEASONS.map{|key, value| value}, message: "is not an option"
    validate :week_of_on_sunday

    # Methods

    private

    # Makes sure that the week_of variable 
    def week_of_on_sunday
        if self.week_of.strftime("%A") == "Sunday"
            return true
        end
        false
    end

end
