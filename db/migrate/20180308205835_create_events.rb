class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.integer :player_id
      t.string :description
      t.datetime :event_time

      t.timestamps
    end
  end
end
