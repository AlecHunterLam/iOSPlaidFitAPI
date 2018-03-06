module Api::V1
    class RosteredSerializer < ActiveModel::Serializer
        attributes :id, :team_id, :user_id
        belongs_to :user
        belongs_to :team
    end
end