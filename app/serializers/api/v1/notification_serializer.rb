module Api::V1
  class NotificationSerializer < ActiveModel::Serializer
    attributes :id, :user_id, :receiver_id, :priority, :message, :notified_time
    belongs_to :user
  end
end
