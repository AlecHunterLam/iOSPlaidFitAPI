class TeamCalculationsController < ApplicationController

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
        if @team_calculation.save
            render json: @team_calculation, status: :created, location: @team_calculation
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

