class RemoveActiveFromNotifications < ActiveRecord::Migration[5.1]
  def change
    remove_column :notifications, :active
  end
end
