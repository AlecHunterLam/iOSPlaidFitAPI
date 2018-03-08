class EarnedBadge < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :badges

  # Scopes

  # Validations
  validates_presence_of :user_id, :badge_id, :date_earned
  validates_date :date_earned, on_or_before: Date.current

  # Methods


end
