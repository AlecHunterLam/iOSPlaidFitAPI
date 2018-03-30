class FixSeasonRankInTeamCalculations < ActiveRecord::Migration[5.1]
  def change
    remove_column :team_calculations, :rank
    add_column :team_calculations, :season_rank, :integer
  end
end
