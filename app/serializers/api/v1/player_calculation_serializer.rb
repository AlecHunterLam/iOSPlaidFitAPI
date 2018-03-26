module Api::V1
  class PlayerCalculationSerializer < ActiveModel::Serializer
    attributes :id, :week_of, :sleep_average, :hydration_average, :stress_average, :soreness_average, :load_average, :team_id, :season, :season_rank
    belongs_to :user
  end
end
