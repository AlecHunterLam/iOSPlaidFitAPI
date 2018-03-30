class AddPostPractiveAverageFields < ActiveRecord::Migration[5.1]
  def change
    add_column :player_calculations, :personal_performance_average,:float
    add_column :player_calculations, :practice_difficulty_average,:float

    add_column :team_calculations, :practice_difficulty_average,:float
  end
end
