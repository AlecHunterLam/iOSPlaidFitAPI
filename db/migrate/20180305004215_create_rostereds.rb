class CreateRostereds < ActiveRecord::Migration[5.1]
  def change
    create_table :rostereds do |t|
      t.integer :team_id
      t.integer :user_id

      t.timestamps
    end
  end
end
