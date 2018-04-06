module Api::V1
    class PracticesController < ApplicationController

        swagger_controller :practices, "Practices Management"

        swagger_api :index do
            summary "Fetches all Practices"
            notes "This lists all the Practices"
        end

        swagger_api :show do
            summary "Shows one Practice"
            param :path, :id, :integer, :required, "Practice ID"
            notes "This lists details of one practice"
            response :not_found
        end

        swagger_api :create do
            summary "Creates a new Practice"
            param :form, :team_id, :integer, :required, "Team ID"
            param :form, :duration, :integer, :required, "Duration"
            param :form, :difficulty, :integer, :required, "Difficulty"
            param :form, :practice_time, :datetime, :required, "Date"
            response :not_acceptable
        end

        swagger_api :update do
            summary "Updates an existing Practice"
            param :path, :id, :integer, :required, "Practice ID"
            param :path, :team_id, :integer, :required, "Team ID"
            param :form, :duration, :integer, :optional, "Duration"
            param :form, :difficulty, :integer, :optional, "Difficulty"
            param :form, :practice_time, :datetime, :optional, "Date"
            response :not_found
            response :not_acceptable
        end

        swagger_api :destroy do
            summary "Deletes an existing Practice"
            param :path, :id, :integer, :required, "Practice ID"
            response :not_found
        end

        before_action :set_practice, only: [:show, :update, :destroy]

        # GET /practices
        def index
            @practices = Practice.all
            render json: @practices
        end

        # GET /practices/1
        def show
            render json: @practice
        end

        # POST /practices
        def create
            @practice = Practice.new(practice_params)
            if @practice.save
                render json: @practice, status: :created, location: [:v1, @practice]
            else
                render json: @practice.errors, status: :unprocessable_entity
            end
        end

        # PATCH/PUT /practices/1
        def update
            if @practice.update(practice_params)
                render json: @practice
            else
                render json: @practice.errors, status: :unprocessable_entity
            end
        end

        # DELETE /practices/1
        def destroy
            @practice.destroy
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_practice
            @practice = Practice.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def practice_params
            params.permit(:team_id, :duration, :difficulty, :practice_time)
        end

    end
end
