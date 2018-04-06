class AddMonotonyToSurveys < ActiveRecord::Migration[5.1]
  def change
    add_column :surveys, :monotony, :float
  end
end
