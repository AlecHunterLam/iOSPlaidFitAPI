class CreatePractices < ActiveRecord::Migration[5.1]
  def change
    create_table :practices do |t|
      t.integer :team_id
      t.integer :duration
      t.integer :difficulty
      t.date :date

      t.timestamps
    end
  end
end
