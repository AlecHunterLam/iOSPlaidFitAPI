class Practice < ApplicationRecord

    # Relationships
    belongs_to :team

    # Scopes
    # select all practices for given week, startDate and endDate should both be Mondays
    scope :practice_in_week,  (startDate, endDate) -> { where("practice_time BETWEEN startDate AND endDate") }
    # get practice given specific date (assume startime = 0:0:0 of day, and 23:59:59)
    scope :practice_on_date,  (startTime,endTime)          -> { where("practice_time BETWEEN startTime AND endTime") }
    # get the practices for a specific teaam
    scope :for_team,          (team_id)            -> { where(team_id: team_id) }
    # get all the practices in the range of an arbitrary set of dates
    scope :practice_in_range, (startDate, endDate) -> { where("practice_time BETWEEN startDate AND endDate") }
    # get all the practices for a specific difficulty
    scope :for_difficulty,    (difficulty)         -> { where("difficulty == ?", difficulty)}


    # Validations
    validates_presence_of :team_id, :duration, :difficulty, :practice_time
    validates :duration, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 180 }
    validates :difficulty, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }
    validates_date :date
    # practice must be on the same day as today, or in the future
    validate :practice_day_validation

    # Methods

    # check that the date of the practice is today or in the future
    def practice_day_validation?
      practice_day = self.practice_time.day
      practice_month = self.practice_time.month
      practice_year = self.practice_time.year
      current_day = Time.now.day
      current_month = Time.now.day
      current_year = Time.now.year
      # practice in the past
      if (practice_day < current_day && (practice_month <= current_month || practice_year <= current_year))
        return false
      elsif practice_day < current_day || practice_month < current_month || practice_year < current_year
        return false
      else
        return true
      end
    end
end
