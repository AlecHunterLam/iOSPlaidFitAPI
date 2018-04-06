class AddFreshnessIndexToSurveys < ActiveRecord::Migration[5.1]
  def change
    add_column :surveys, :freshness_index, :float
  end
end
