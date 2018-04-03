class RenamePlayerIdToUserIdInEvents < ActiveRecord::Migration[5.1]
  def change
    rename_column :events, :user_id, :user_id
  end
end
