class RenamePracticeDateToPracticeTime < ActiveRecord::Migration[5.1]
  def change
    rename_column :practices, :date, :practice_time
  end
end
