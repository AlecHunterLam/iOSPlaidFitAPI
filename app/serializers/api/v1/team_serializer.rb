module Api::V1
  class TeamSerializer < ActiveModel::Serializer
    attributes :id, :sport, :gender, :season, :active
    has_many :users, through: :team_assignments
    has_many :team_calculations
    has_many :practices
  end
end
