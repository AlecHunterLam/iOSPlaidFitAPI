class PlayerCalculation < ApplicationRecord
  # Constants
  # SEASONS = [['Fall', :fall], ['Winter', :winter], ['Spring', :spring]]

  # Relationships
  belongs_to :user

  # Scopesg

  # Validations
  validates_presence_of :user_id, :week_of, :season
  validates_date :week_of
  validate :validate_season
  validate :validate_week_of
  # Need stats validations

  # Methods
  private
  def validate_season
    input_season = self.season
    # correct format
    test_regex = /^(Fall|Winter|Spring)-20([0-9]{2})$/
    return test_regex.match(input_season)
  end

  def validate_week_of
    input_week_of = self.week_of
    # correct day, assuming input week is a Time object
    # http://ruby-doc.org/core-2.2.0/Time.html#method-i-sunday-3F
    return input_week_of.monday?
  end

end
