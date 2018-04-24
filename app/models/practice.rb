class Practice < ApplicationRecord
    # callback to set the session load
    before_save :calculate_session_load

    # Relationships
    belongs_to :team
    has_many :surveys

    # Scopes
    # select all practices for given week, startDate and endDate should both be Mondays
    scope :practice_in_week,  -> (startDate, endDate) { where("practice_time BETWEEN startDate AND endDate") }
    # get practice given specific date (assume startime = 0:0:0 of day, and 23:59:59)
    scope :practice_on_date,  -> (startTime,endTime)  { where("practice_time BETWEEN startTime AND endTime") }
    # get the practices for a specific teaam
    scope :for_team,          -> (team_id)            { where(team_id: team_id) }
    # get all the practices in the range of an arbitrary set of dates
    scope :practice_in_range, -> (startDate, endDate) { where("practice_time BETWEEN startDate AND endDate") }
    # get all the practices for a specific difficulty
    scope :for_difficulty,    -> (difficulty)         { where("difficulty == ?", difficulty) }
    # order the practices by time
    scope :chronological,                          -> { order(:practice_time) }

    # Validations
    validates_presence_of :team_id, :duration, :difficulty, :practice_time
    validates :duration, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 180 }
    validates :difficulty, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
    # practice must be on the same day as today, or in the future => removed for development
    # validates_date :practice_time, on_or_after: Time.now

    # Methods


    def calculate_session_load
      self.session_load = self.duration * self.difficulty
    end
end
