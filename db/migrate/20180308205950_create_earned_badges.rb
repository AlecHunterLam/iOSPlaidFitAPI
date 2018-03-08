class CreateEarnedBadges < ActiveRecord::Migration[5.1]
  def change
    create_table :earned_badges do |t|
      t.integer :badge_id
      t.integer :player_id
      t.datetime :date_earned

      t.timestamps
    end
  end
end
