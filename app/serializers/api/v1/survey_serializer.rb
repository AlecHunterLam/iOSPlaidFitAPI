module Api::V1
  class SurveySerializer < ActiveModel::Serializer
    attributes :id, :user_id, :type, :response, :completed, :season
    belongs_to :user
  end
end