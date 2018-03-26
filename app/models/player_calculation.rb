class PlayerCalculation < ApplicationRecord
  # Constants
  # SEASONS = [['Fall', :fall], ['Winter', :winter], ['Spring', :spring]]

  # Relationships
  belongs_to :user

  # Scopesg

  # Validations
  validates_presence_of :user_id, :week_of, :season
  validate :validate_season
  validate :validate_week_of
  validates_numericality_of :sleep_average, :hydration_average, :stress_average, :load_average, greater_than_or_equal_to: 0, only_integer: false

  # Methods
  private
  def validate_season
    input_season = self.season
    # correct format
    test_regex = /^(Fall|Winter|Spring)-20([0-9]{2})$/
    return input_season === test_regex
  end

  def validate_week_of
    input_week_of = self.week_of
    # correct day, assuming input week is a Time object
    # http://ruby-doc.org/core-2.2.0/Time.html#method-i-sunday-3F
    return input_week_of.sunday?
  end

end
