module Api::V1
  class BadgeSerializer < ActiveModel::Serializer
    attributes :id, :badge_name, :requirements
    has_many :earned_badges
  end
end
