# calculate the session load per practice
class SurveyService
  def initialize(params)
    @team_id = params[:team_id]
    @duration = params[:duration]
    @difficulty = params[:difficulty]
    @practice_time = params[:practice_time] # time the practice took place/is scheduled
    @practice = Practice.new
  end

  def set_fields_of_practice
    @practice.session_load = @difficulty * @duration
    return @practice
  end
  
end
