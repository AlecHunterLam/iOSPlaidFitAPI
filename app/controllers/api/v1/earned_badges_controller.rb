module Api::V1
  class EarnedBadgesController < ApplicationController
    # documentation
    swagger_controller :earned_badges, "Earned Badges Management"

    swagger_api :index do
      summary "Fetches all Earned Badges"
      notes "This lists all the earned badges"
    end

    swagger_api :show do
      summary "Shows one Earned Badge"
      param :path, :id, :integer, :required, "Earned Badge ID"
      notes "This lists details of one earned badge"
      response :not_found
    end

    swagger_api :create do
      summary "Creates a new Earned Badge"
      param :form, :user_id, :integer, :required, "User ID"
      param :form, :badge_id, :integer, :required, "Badge ID"
      response :not_acceptable
    end

    swagger_api :update do
      summary "Updates an existing Earned Badge"
      param :path, :id, :integer, :required, "Earned Badge ID"
      param :form, :user_id, :integer, :optional, "User ID"
      param :form, :badge_id, :integer, :optional, "Badge ID"
      response :not_found
      response :not_acceptable
    end

    swagger_api :destroy do
      summary "Deletes an existing Earned Badge"
      param :path, :id, :integer, :required, "Earned Badge ID"
      response :not_found
    end


    # callbacks
    before_action :set_earned_badges, only: [:show, :update, :destroy]

    # GET /earned_badges
    def index
      @earned_badges = EarnedBadge.all
      render json: @earned_badges
    end

    # GET /earned_badges/1
    def show
      render json: @earned_badge
    end

    # POST /earned_badges
    def create
      @earned_badge = EarnedBadge.new(earned_badge_params)
      @earned_badge.date_earned = Time.now
      if @earned_badge.save
        render json: @earned_badge, status: :created, location: [:v1, @earned_badge]
      else
        render json: @earned_badge.errors, status: :unprocessable_entity
      end
    end

    # PUT/PATCH /earned_badges/1
    def update
      if @earned_badge.update(earned_badge_params)
        render json: @earned_badge
      else
        render json: @earned_badge.errors, status: :unprocessable_entity
      end
    end

    # DELETE /earned_badges/1
    def destroy
      @earned_badge.destroy
    end

    private
    # set the earned_badges object
    def set_earned_badges
      @earned_badge = EarnedBadge.find(params[:id])
    end

    # whitelist allowed values for an earned badge
    def earned_badge_params
      params.permit(:badge_id, :player_id)
    end

  end
end
