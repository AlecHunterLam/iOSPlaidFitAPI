module Contexts
  module PlayerCalculationContexts
    def create_player_calculations
      @pc1 = Player_calculation.create(user_id: "1", sleep_average: 8.4, hydration_average: 22.0, soreness_average: 4.5, load_average: 6.0, season: "fall", season_rank: 3, weekly_load: 42.0, weekly_strain: 30.0, life_stress_average: 3.5, academic_stress_average: 4.0, sleep_quality_average: 4.0, hydration_quality_average: 1.0, personal_performance_average: 7.0, practice_difficulty_average: 6.3)
    end

    def delete_player_calculations
      @pc1.delete
    end
  end
end
