module Api::V1
  class PracticeSerializer < ActiveModel::Serializer
    attributes :id, :team_id, :duration, :difficuly, :date
    belongs_to :team
    has_many :surveys
  end
end
