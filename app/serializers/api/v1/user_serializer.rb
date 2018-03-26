module Api::V1
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :first_name, :last_name, :andrew_id, :email, :major, :phone, :role, :active
    has_many :player_calculations
    has_many :surveys
    has_many :events
    has_many :earned_badges
    has_many :notifications
    has_many :rostereds
  end
end
