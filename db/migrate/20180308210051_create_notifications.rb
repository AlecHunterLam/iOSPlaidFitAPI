class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :priority
      t.string :message
      t.datetime :notified_time

      t.timestamps
    end
  end
end
