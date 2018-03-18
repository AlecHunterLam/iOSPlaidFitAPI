class CreateTeamCalculations < ActiveRecord::Migration[5.1]
  def change
    create_table :team_calculations do |t|
      t.date :week_of
      t.integer :sleep
      t.integer :hydration
      t.integer :stress
      t.integer :load
      t.integer :team_id
      t.string :season
      t.string :rank

      t.timestamps
    end
  end
end
