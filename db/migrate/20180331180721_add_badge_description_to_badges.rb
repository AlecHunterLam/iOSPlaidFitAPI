class AddBadgeDescriptionToBadges < ActiveRecord::Migration[5.1]
  def change
    add_column :badges, :badge_description, :string
  end
end
