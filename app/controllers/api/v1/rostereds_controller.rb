module Api::V1
    class RosteredsController < ApplicationController

        swagger_controller :rostereds, "Rostereds Management"

        swagger_api :index do
            summary "Fetches all Rostereds"
            notes "This lists all the Rostereds"
        end

        swagger_api :show do
            summary "Shows one Rostered"
            param :path, :id, :integer, :required, "Rostered ID"
            notes "This lists details of one rostered"
            response :not_found
        end

        swagger_api :create do
            summary "Creates a new Rostered"
            param :form, :team_id, :integer, :required, "Team ID"
            param :form, :user_id, :integer, :required, "User ID"
            response :not_acceptable
        end

        swagger_api :update do
            summary "Updates an existing Rostered"
            param :path, :id, :integer, :required, "Rostered ID"
            param :path, :team_id, :integer, :required, "Team ID"
            param :path, :user_id, :integer, :required, "User ID"
            response :not_found
            response :not_acceptable
        end

        swagger_api :destroy do
            summary "Deletes an existing Rostered"
            param :path, :id, :integer, :required, "Rostered ID"
            response :not_found
        end

        before_action :set_rostered, only: [:show, :update, :destroy]

        # GET /rostereds
        def index
            @rostereds = Rostered.all
            render json: @rostereds
        end

        # GET /rostereds/1
        def show
            render json: @rostered
        end

        # POST /rostereds
        def create
            @rostered = Rostered.new(rostered_params)
            if @rostered.save
                render json: @rostered, status: :created, location: @rostered
            else
                render json: @rostered.errors, status: :unprocessable_entity
            end
        end

        # PATCH/PUT /rostereds/1
        def update
            if @rostered.update(rostered_params)
                render json: @rostered
            else
                render json: @rostered.errors, status: :unprocessable_entity
            end
        end

        # DELETE /rostereds/1
        def destroy
            @rostered.destroy
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_rostered
            @rostered = Rostered.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def rostered_params
            params.permit(:team_id, :user_id)
        end

    end
end
