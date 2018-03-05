class Team < ApplicationRecord

    # Array constants
    SPORTS = [['Soccer', 'soccer'], ['Basketball', 'bball'], ['Tennis', 'tennis'], ['Volleyball', 'vball'], ['Diving', 'diving']]
    GENDERS = [['Men', 'men'], ['Women', 'women']]
    SEASONS = [['Fall', 'fall'], ['Winter', 'winter'], ['Spring', 'spring']]

    # Relationships
    has_many :rostereds
    has_many :team_calculations
    has_many :practices

    # Scopes
    scope :active,       -> { where(active: true) }
    scope :inactive,     -> { where(active: false) }
    scope :fall_teams,   -> { where(season: 'fall') }
    scope :winter_teams, -> { where(season: 'winter') }
    scope :spring_teams, -> { where(season: 'spring') }
    scope :mens_teams,   -> { where(gender: 'men') }
    scope :womens_teams, -> { where.not(gender: 'men') }   

    # Validations
    validates_presence_of :sport, :gender, :season, :active
    validates_inclusion_of :sport, in: SPORTS.map{|key, value| value}, message: "is not an option"
    validates_inclusion_of :gender, in: GENDERS.map{|key, value| value}, message: "is not an option"
    validates_inclusion_of :season, in: SEASONS.map{|key, value| value}, message: "is not an option"

    # Methods

end
