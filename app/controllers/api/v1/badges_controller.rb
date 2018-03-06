module API::V1
    class BadgesController < ApplicationController

        swagger_controller :badges, "Badges Management"

        swagger_api :index do
            summary "Fetches all Badges"
            notes "This lists all the Badges"
        end

        swagger_api :show do
            summary "Shows one Badge"
            param :path, :id, :integer, :required, "Badge ID"
            notes "This lists details of one badge"
            response :not_found
        end

        swagger_api :create do
            summary "Creates a new Badge"
            param :form, :badge_name, :string, :required, "Badge Name"
            param :form, :requirements, :string, :required, "Requirements"
            response :not_acceptable
        end

        swagger_api :update do
            summary "Updates an existing Badge"
            param :path, :id, :integer, :required, "Badge ID"
            param :form, :badge_name, :string, :optional, "Badge Name"
            param :form, :requirements, :string, :optional, "Requirements"
            response :not_found
            response :not_acceptable
        end

        swagger_api :destroy do
            summary "Deletes an existing Badge"
            param :path, :id, :integer, :required, "Badge ID"
            response :not_found
        end

        before_action :set_badge, only: [:show, :update, :destroy]

        # GET /badges
        def index
            @badges = Badge.all
            render json: @badges
        end

        # GET /badges/1
        def show
            render json: @badge
        end

        # POST /badges
        def create
            @badge = Badge.new(badge_params)
            if @badge.save
                render json: @badge, status: :created, location: @badge
            else
                render json: @badge.errors, status: :unprocessable_entity
            end
        end

        # PATCH/PUT /badges/1
        def update
            if @badge.update(badge_params)
                render json: @badge
            else
                render json: @badge.errors, status: :unprocessable_entity
            end
        end

        # DELETE /badges/1
        def destroy
            @badge.destroy
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_badge
            @badge = Badge.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def badge_params
            params.permit(:badge_name, :requirements)
        end

    end
end