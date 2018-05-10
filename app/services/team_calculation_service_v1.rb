require 'descriptive_statistics'

SECONDS_IN_ONE_DAY = 86400

class SurveyService
  def initialize(partial_calculation_object)
    @team_calculation = partial_calculation_object
  end


  def get_team_calculation_object
    # must start on a monday
    if !(@team_calculation.week_of.monday?)
      return nil
    end

    # get start of week/end of week
    start_week = DateTime.new(@team_calculation.week_of.year, @team_calculation.week_of.month, @team_calculation.week_of.day, 0,0,0, @team_calculation.strftime( "%z" ));
    end_week = DateTime.new(@team_calculation.week_of.year, @team_calculation.week_of.month, @team_calculation.week_of.day, 23,59,59, a.strftime( "%z" )) + 6;

    all_team_post = Survey.for_team(@team_calculation.team_id).post_practice.surveys_for_week(start_week, end_week)
    all_team_wellness = Survey.for_team(@team_calculation.team_id).daily_wellness.surveys_for_week(start_week, end_week)

    # set daily wellness fields
    all_team_wellness.each do |s|
      
    end



  end
end
