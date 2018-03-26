class AddSessionLoadToPractices < ActiveRecord::Migration[5.1]
  def change
    add_column :surveys, :session_load, :float 
  end
end
