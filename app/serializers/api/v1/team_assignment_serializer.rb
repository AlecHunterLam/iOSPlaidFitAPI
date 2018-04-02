module Api::V1
    class TeamAssignmentSerializer < ActiveModel::Serializer
        attributes :id, :team_id, :user_id
        belongs_to :user
        belongs_to :team
    end
end
