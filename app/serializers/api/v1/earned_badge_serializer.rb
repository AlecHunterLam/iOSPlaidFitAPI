module Api::V1
  class EarnedBadgeSerializer < ActiveModel::Serializer
    attributes :id, :user_id, :badge_id, :date_earned
    belongs_to :badge
    belongs_to :user
  end
end
