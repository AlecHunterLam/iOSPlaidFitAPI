class AddPracticeIdToSurveys < ActiveRecord::Migration[5.1]
  def change
    add_column :surveys, :practice_id, :integer
  end
end
