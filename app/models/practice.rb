class Practice < ApplicationRecord

    # Relationships
    belongs_to :team

    # Scopes
    # select all practices for given week, startDate and endDate should both be Mondays
    scope :practice_in_week, (startDate, endDate) -> { where("date BETWEEN startDate AND endDate") }
    # get practice given specific date
    scope :practice_on_date, (givenDate)          -> { where("date == givenDate") }

    # Validations
    validates_presence_of :team_id, :duration, :difficulty, :date
    validates :duration, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 180 }
    validates :difficulty, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }
    validates_date :date

    # Methods

end