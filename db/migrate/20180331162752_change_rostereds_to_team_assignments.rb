class ChangeRosteredsToTeamAssignments < ActiveRecord::Migration[5.1]
  def change
    rename_table :rostereds, :team_assignments
  end
end
