class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :team_id
      t.string :andrew_id
      t.string :email
      t.string :major
      t.string :phone
      t.string :role
      t.boolean :active

      t.timestamps
    end
  end
end
