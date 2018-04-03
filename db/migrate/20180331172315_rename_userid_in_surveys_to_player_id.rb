class RenameUseridInSurveysToPlayerId < ActiveRecord::Migration[5.1]
  def change
    rename_column :surveys, :user_id, :user_id
  end
end
