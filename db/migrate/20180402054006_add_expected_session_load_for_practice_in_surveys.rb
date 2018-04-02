class AddExpectedSessionLoadForPracticeInSurveys < ActiveRecord::Migration[5.1]
  def change
    add_column :surveys, :expected_session_load, :float
  end
end
