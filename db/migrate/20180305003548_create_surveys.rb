class CreateSurveys < ActiveRecord::Migration[5.1]
  def change
    create_table :surveys do |t|
      t.integer :user_id
      t.string :type
      t.string :response
      t.date :completed
      t.string :season

      t.timestamps
    end
  end
end
