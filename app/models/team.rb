class Team < ApplicationRecord

    # Array constants
    SPORTS = [['Soccer', :soccer], ['Basketball', :basketball], ['Tennis', :tennis], ['Volleyball', :volleyball], ['Swimming & Diving', :swimming_and_diving],
              ['Baseball', :baseball], ['Beach Volleyball', :beach_volleyball], ['Bowling', :bowling], ['Cross Country', :cross_country],
              ['Fencing', :fencing], ['Field Hockey', :field_hockey], ['Football', :football], ['Golf', :golf], ['Gymnastics', :gymnastics],
              ['Ice Hockey', :ice_hockey], ['Lacrosse', :lacrosse], ['Rifle', :rifle], ['Rowing', :rowing], ['Skiing', :skiing], ['Softball', :softball],
              ['Indoor Track and Field', :indoor_track_and_field],['Outdoor Track and Field', :outdoor_track_and_field], ['Water Polo', :water_polo], ['Wrestling', :wrestling]]
    GENDERS = [['Men', :men], ['Women', :women]]
    SEASONS = [['Fall', :fall], ['Winter', :winter], ['Spring', :spring]]

    # Class Variables
    @@current_seasons = self.calculate_current_seasons

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
    validates_inclusion_of :sport, in: SPORTS.map{|key, value| value}, message: "is not a valid sport at Carnegie Mellon"
    validates_inclusion_of :gender, in: GENDERS.map{|key, value| value}, message: "is not an option"
    validates_inclusion_of :season, in: SEASONS.map{|key, value| value}, message: "is not a valid sports season"

    # Methods

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
