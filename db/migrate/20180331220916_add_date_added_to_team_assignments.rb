class AddDateAddedToTeamAssignments < ActiveRecord::Migration[5.1]
  def change
    add_column :team_assignments, :date_added, :datetime
  end
end
