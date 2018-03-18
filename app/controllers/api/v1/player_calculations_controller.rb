module Api::V1
    class PlayerCalculationsController < ApplicationController

        swagger_controller :player_calculations, "Player Calculations Management"

        swagger_api :index do
            summary "Fetches all Player Calculations"
            notes "This lists all the Player Calculations"
        end

        swagger_api :show do
            summary "Shows one Player Calculation"
            param :path, :id, :integer, :required, "Player Calculation ID"
            notes "This lists details of one player calculation"
            response :not_found
        end

        swagger_api :create do
            summary "Creates a new Player Calculation"
            param :form, :player_id, :integer, :required, "Player ID"
            param :form, :week_of, :date, :required, "Week Of"
            response :not_acceptable
        end

        swagger_api :update do
            summary "Updates an existing Player Calculation"
            param :path, :id, :integer, :required, "Player Calculation ID"
            param :path, :player_id, :integer, :required, "Player ID"
            param :form, :week_of, :date, :optional, "Week Of"
            response :not_found
            response :not_acceptable
        end

        swagger_api :destroy do
            summary "Deletes an existing Player Calculation"
            param :path, :id, :integer, :required, "Player Calculation ID"
            response :not_found
        end

        before_action :set_player_calculation, only: [:show, :update, :destroy]

        # GET /player_calculations
        def index
            @player_calculations = PlayerCalculation.all
            render json: @player_calculations
        end

        # GET /player_calculations/1
        def show
            render json: @player_calculation
        end

        # POST /player_calculations
        def create
            @player_calculation = PlayerCalculation.new(player_calculation_params)
            if @player_calculation.save
                render json: @player_calculation, status: :created, location: [:v1, @player_calculation]
            else
                render json: @player_calculation.errors, status: :unprocessable_entity
            end
        end

        # PATCH/PUT /player_calculations/1
        def update
            if @player_calculation.update(player_calculation_params)
                render json: @player_calculation
            else
                render json: @player_calculation.errors, status: :unprocessable_entity
            end
        end

        # DELETE /player_calculations/1
        def destroy
            @player_calculation.destroy
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_player_calculation
            @player_calculation = PlayerCalculation.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def player_calculation_params
            params.permit(:player_id, :week_of)
        end

    end
end
