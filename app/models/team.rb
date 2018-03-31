class Team < ApplicationRecord

    # Array constants
    SPORTS = [['Soccer', :soccer], ['Basketball', :bball], ['Tennis', :tennis], ['Volleyball', :vball], ['Swimming & Diving', :s_and_d],
              ['Baseball', :baseball], ['Beach Volleyball', :beach_vball], ['Bowling', :bowling], ['Cross Country', :xc],
              ['Fencing', :fencing], ['Field Hockey', :f_hockey], ['Football', :football], ['Golf', :golf], ['Gymnastics', :gymnastics],
              ['Ice Hockey', :ice_hockey], ['Lacrosse', :lax], ['Rifle', :rifle], ['Rowing', :rowing], ['Skiing', :skiing], ['Softball', :softball],
              ['Track and Field', :t_and_f], ['Water Polo', :w_polo], ['Wrestling', :wrestling]]
    GENDERS = [['Men', :men], ['Women', :women]]
    SEASONS = [['Fall', :fall], ['Winter', :winter], ['Spring', :spring]]

    # Relationships
    has_many :team_assignments
    has_many :team_calculations
    has_many :practices
    has_many :users, through: :team_assignments

    # Scopes
    scope :active,              -> { where(active: true) }
    scope :inactive,            -> { where(active: false) }
    scope :season_teams,  ->  (team) { where(seasons: team) }
    scope :team_of_gender,   ->  (g) { where(gender: g) }

    # Validations
    validates_presence_of :sport, :gender, :season, :active
    validates_inclusion_of :sport, in: SPORTS.map{|key, value| value}, message: "is not a valid sport at Carnegie Mellon"
    validates_inclusion_of :gender, in: GENDERS.map{|key, value| value}, message: "is not an option"
    validates_inclusion_of :season, in: SEASONS.map{|key, value| value}, message: "is not a valid sports season"

    # Methods

end
