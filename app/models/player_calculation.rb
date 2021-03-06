class PlayerCalculation < ApplicationRecord
  # Constants
  # SEASONS = [['Fall', :fall], ['Winter', :winter], ['Spring', :spring]]
  # after_validation :set_relative_rank
  before_save :sanitize_date_time

  # Relationships
  belongs_to :user

  # Scopes
  scope :for_user,   -> (user_id) { where(user_id: user_id) }
  scope :for_season,   -> (season) { where(season: season) }
  scope :for_week,    -> (monday) { where(week_of: monday) }
  scope :rank_by_weekly_load,   ->{ order(weekly_load: :ASC) }

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

  # added to system after save, now need to set thte relative rank of the calculation for that week
  def set_relative_rank
    ranked_week_calculations_for_season = PlayerCalculation.for_user(self.user_id).for_season(self.season).rank_by_weekly_load
    i = ranked_week_calculations_for_season.length
    ranked_week_calculations_for_season.each do |calc|
      calc.update(season_rank: i)
      calc.save!
      i = i - 1
    end
    return
  end

  def sanitize_date_time
    self.week_of = DateTime.new(self.week_of.year, self.week_of.month, self.week_of.day, 0,0,0, self.week_of.strftime( "%z" ));
  end

end
