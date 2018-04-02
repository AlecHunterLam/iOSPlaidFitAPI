class AddActiveFieldToTeamAssignments < ActiveRecord::Migration[5.1]
  def change
    add_column :team_assignments, :active, :boolean
  end
end
