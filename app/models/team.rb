class Team < ApplicationRecord

    # Array constants
    SPORTS = [['Soccer', :soccer], ['Basketball', :basketball], ['Tennis', :tennis], ['Volleyball', :volleyball], ['Swimming & Diving', :swimming_and_diving],
              ['Baseball', :baseball], ['Beach Volleyball', :beach_volleyball], ['Bowling', :bowling], ['Cross Country', :cross_country],
              ['Fencing', :fencing], ['Field Hockey', :field_hockey], ['Football', :football], ['Golf', :golf], ['Gymnastics', :gymnastics],
              ['Ice Hockey', :ice_hockey], ['Lacrosse', :lacrosse], ['Rifle', :rifle], ['Rowing', :rowing], ['Skiing', :skiing], ['Softball', :softball],
              ['Indoor Track and Field', :indoor_track_and_field],['Outdoor Track and Field', :outdoor_track_and_field], ['Water Polo', :water_polo], ['Wrestling', :wrestling]]
    GENDERS = [['Men', :men], ['Women', :women]]
    SEASONS = [['Fall', :fall], ['Winter', :winter], ['Spring', :spring]]



    # Relationships
    has_many :team_assignments
    has_many :team_calculations
    has_many :practices
    has_many :users, through: :team_assignments

    # Scopes
    scope :active,              ->           { where(active: true) }
    scope :inactive,            ->           { where(active: false) }
    scope :for_season,          ->  (season) { where("season == ?", season) }
    scope :for_gender,          ->  (gender) { where("gender == ?", gender) }
    scope :for_sport,           ->  (sport)  { where("sport == ?", sport) }

    # Validations
    validates_presence_of :sport, :gender, :season, :active
    # set to key for now, set to value later
    validates_inclusion_of :sport, in: SPORTS.map{|key, value| key}, message: "is not a valid sport at Carnegie Mellon"
    validates_inclusion_of :gender, in: GENDERS.map{|key, value| key}, message: "is not an option"
    validates_inclusion_of :season, in: SEASONS.map{|key, value| key}, message: "is not a valid sports season"

    # Methods




end
