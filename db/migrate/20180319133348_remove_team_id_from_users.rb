class RemoveTeamIdFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :team_id
  end
end
