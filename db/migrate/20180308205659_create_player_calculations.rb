class CreatePlayerCalculations < ActiveRecord::Migration[5.1]
  def change
    create_table :player_calculations do |t|
      t.integer :user_id
      t.date :weak_of
      t.float :sleep_average
      t.float :hydration_average
      t.float :stress_average
      t.float :soreness_average
      t.float :load_average
      t.string :season
      t.integer :season_rank

      t.timestamps
    end
  end
end
