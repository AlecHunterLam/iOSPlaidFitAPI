require './app/services/team_calculation_service_v1.rb'


module Api::V1
    class TeamCalculationsController < ApplicationController

        swagger_controller :team_calculations, "Team Calculations Management"

        swagger_api :index do
            summary "Fetches all Team Calculations"
            notes "This lists all the Team Calculations"
        end

        swagger_api :show do
            summary "Shows one Team Calculation"
            param :path, :id, :integer, :required, "Team Calculation ID"
            notes "This lists details of one team calculation"
            response :not_found
        end

        swagger_api :create do
            summary "Creates a new Team Calculation"
            param :form, :team_id, :integer, :required, "Team ID"
            param :form, :week_of, :date, :required, "Week Of"
            response :not_acceptable
        end

        swagger_api :update do
            summary "Updates an existing Team Calculation"
            param :path, :id, :integer, :required, "Team Calculation ID"
            param :path, :team_id, :integer, :required, "Team ID"
            param :form, :week_of, :date, :optional, "Week Of"
            response :not_found
            response :not_acceptable
        end

        swagger_api :destroy do
            summary "Deletes an existing Team Calculation"
            param :path, :id, :integer, :required, "Team Calculation ID"
            response :not_found
        end

        before_action :set_team_calculation, only: [:show, :update, :destroy]

        # GET /team_calculations
        def index
            @team_calculations = TeamCalculation.all
            render json: @team_calculations
        end

        # GET /team_calculations/1
        def show
            render json: @team_calculation
        end

        # POST /team_calculations
        def create
            @team_calculation = TeamCalculation.new(team_calculation_params)

            # set the current season
            @team = Team.find(@team_calculation.team_id)

            @team_calculation.season = @team.season.to_s + "-" + (Time.now.year).to_s

            @team_calculation = @team_calculation.get_team_calculation_object

            if @team_calculation.save
                render json: @team_calculation, status: :created, location: [:v1, @team_calculation]
            else
                render json: @team_calculation.errors, status: :unprocessable_entity
            end
        end

        # PATCH/PUT /team_calculations/1
        def update
            if @team_calculation.update(team_calculation_params)
                render json: @team_calculation
            else
                render json: @team_calculation.errors, status: :unprocessable_entity
            end
        end

        # DELETE /team_calculations/1
        def destroy
            @team_calculation.destroy
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_team_calculation
            @team_calculation = TeamCalculation.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def team_calculation_params
            params.permit(:team_id, :week_of)
        end

    end
end
