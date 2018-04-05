module Contexts
  module TeamCalculationContexts
    def create_team_calculations
      @tc1 = Team_calculation.create(team_id: 1, season: "fall", weekly_load: 50.0, sleep_average: 7.0, hydration_average: 16.9, soreness_average: 6.5, load_average: 5.5, weekly_strain: 32.6, season_rank: 2, life_stress_average: 4.3, academic_stress_average: 3.9, sleep_quality_average: 4.0, hydration_quality_average: 3.0, practice_difficulty_average: 5.8)
    end

    def destroy_team_calculations
      @tc1.delete
    end
  end
end 
