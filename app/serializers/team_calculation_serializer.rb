class TeamCalculationSerializer < ActiveModel::Serializer
  attributes :id, :week_of, :sleep, :hydration, :stress, :load, :team_id, :season, :rank
  belongs_to :team
end
