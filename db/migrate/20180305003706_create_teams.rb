class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :sport
      t.string :gender
      t.string :season
      t.boolean :active

      t.timestamps
    end
  end
end
