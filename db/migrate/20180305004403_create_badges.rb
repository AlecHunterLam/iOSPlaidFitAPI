class CreateBadges < ActiveRecord::Migration[5.1]
  def change
    create_table :badges do |t|
      t.string :badge_name
      t.string :requirements

      t.timestamps
    end
  end
end
