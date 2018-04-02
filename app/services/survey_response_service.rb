# extract data from the JSON response


# Daily Wellness JSON
# {
# Q1: # of Hours of Sleep,
# Q2: Very Poor-1 | Poor-2 | Average-3 | Good-4 | Great-5,   (Quality of sleep)
# Q3: Highly Stressed-1 | Stressed-2 | Average-3 | Relaxed-4 | Very Relaxed-5 ,   (Academic stress)
# Q4: Highly Stressed-1 | Stressed-2 | Average-3 | Relaxed-4 | Very Relaxed-5,    (Life stress)
# Q5: Very Sore-1 | Sore-2 | Normal-3 | Feeling Good-4 | Feeling Great-5,         (Soreness)
# Q6: # of ounces of water consumed,
# Q7: Yes-1 | No-0  (Do you feel hydrated)
# }

# Post Practice JSON
# {
# Q1: # RPE Scale,
# Q2: # Personal Performance Sale,
# Q3: Yes-1 | No-0,
# Q4: # of minutes participated | ''
# }

# Empty string from json = Nil

require 'json'

class SurveyResponseService
  def initialize(response,type)
    @type = type
    raw_response = JSON.parse(response)
    

    # set the fields
    if @type == :daily_wellness || @type == "Daily Wellness"
      @hours_of_sleep = response["Q1"]
      @quality_of_sleep = response["Q2"]
      @academic_stress = response["Q3"]
      @life_stress = response["Q4"]
      @soreness = response["Q5"]
      @ounces_of_water_consumed = response["Q6"]
      @hydration_quality = response["Q7"]
    elsif @type == :post_practice || @type == "Post Practice"
      @player_rpe_rating = response["Q1"]
      @player_personal_performance = response["Q2"]
      @participated_in_full_practice = response["Q3"]
      @minutes_participated = response["Q4"]
    else
      return nil
    end



  end

  private


end
