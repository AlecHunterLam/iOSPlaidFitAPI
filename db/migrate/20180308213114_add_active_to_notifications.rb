class AddActiveToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :active, :boolean
  end
end
