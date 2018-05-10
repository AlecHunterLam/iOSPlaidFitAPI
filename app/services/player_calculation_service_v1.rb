require 'descriptive_statistics'

SECONDS_IN_ONE_DAY = 86400

class SurveyService
  def initialize(partial_calculation_object)
    @player_calculation = partial_calculation_object
  end


  def get_player_calculation_object
    # must start on a monday
    if !(Player.find(@player_calculation.user_id).nil?)
      return nil
    end

    # get start of week/end of week
    start_week = DateTime.new(@player_calculation.week_of.year, @player_calculation.week_of.month, @v.week_of.day, 0,0,0, @player_calculation.strftime( "%z" ));
    end_week = DateTime.new(@player_calculation.week_of.year, @player_calculation.week_of.month, @v.week_of.day, 23,59,59, a.strftime( "%z" )) + 6;

    all_player_post = Survey.for_user(@player_calculation.user_id).post_practice.surveys_for_week(start_week, end_week)
    all_player_wellness = Survey.for_user(@player_calculation.user_id).daily_wellness.surveys_for_week(start_week, end_week)

    # set daily wellness fields
    all_player_wellness.each do |s|

    end



  end
end
