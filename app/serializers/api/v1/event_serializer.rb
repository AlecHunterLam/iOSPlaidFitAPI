module Api::V1
  class EventSerializer < ActiveModel::Serializer
    attributes :id, :user_id, :description, :event_time
    belongs_to :user
  end
end
