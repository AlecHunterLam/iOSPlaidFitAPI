module Api::V1
  class EarnedBadgesController < ApplicationController
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
