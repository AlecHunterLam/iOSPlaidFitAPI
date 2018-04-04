module Api::V1
  class PracticeSerializer < ActiveModel::Serializer
    attributes :id, :team_id, :duration, :difficulty, :practice_time
    belongs_to :team
    has_many :surveys
  end
end
