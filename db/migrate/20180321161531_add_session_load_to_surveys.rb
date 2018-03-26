class AddSessionLoadToSurveys < ActiveRecord::Migration[5.1]
  def change
    add_column :practices, :session_load, :float 
  end
end
