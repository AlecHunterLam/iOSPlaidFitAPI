module Api::V1
    class TeamsController < ApplicationController

        swagger_controller :teams, "Teams Management"

        swagger_api :index do
            summary "Fetches all Teams"
            notes "This lists all the Teams"
        end

        swagger_api :show do
            summary "Shows one Team"
            param :path, :id, :integer, :required, "Team ID"
            notes "This lists details of one team"
            response :not_found
        end

        swagger_api :create do
            summary "Creates a new Team"
            param :form, :sport, :string, :required, "Sport"
            param :form, :gender, :string, :required, "Gender"
            param :form, :season, :string, :required, "Season"
            param :form, :active, :boolean, :required, "Active"
            response :not_acceptable
        end

        swagger_api :update do
            summary "Updates an existing Team"
            param :path, :id, :integer, :required, "Team ID"
            param :form, :sport, :string, :optional, "Sport"
            param :form, :gender, :string, :optional, "Gender"
            param :form, :season, :string, :optional, "Season"
            param :form, :active, :boolean, :optional, "Active"
            response :not_found
            response :not_acceptable
        end

        swagger_api :destroy do
            summary "Deletes an existing Team"
            param :path, :id, :integer, :required, "Team ID"
            response :not_found
        end

        before_action :set_team, only: [:show, :update, :destroy]

        # GET /teams
        def index
            @teams = Team.all
            if (params[:active].present?)
                @teams = params[:active] == "true" ? @teams.active : @teams.inactive
            end
            if params[:fall_teams].present? && params[:fall_teams] == "true"
                @teams = @teams.fall_teams
            end
            render json: @teams
        end

        # GET /teams/1
        def show
            render json: @team
        end

        # POST /teams
        def create
            @team = Team.new(team_params)
            if @team.save
                render json: @team, status: :created, location: [:v1, @team]
            else
                render json: @team.errors, status: :unprocessable_entity
            end
        end

        # PATCH/PUT /teams/1
        def update
            if @team.update(team_params)
                render json: @team
            else
                render json: @team.errors, status: :unprocessable_entity
            end
        end

        # DELETE /teams/1
        def destroy
            @team.destroy
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_team
            @team = Team.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def team_params
            params.permit(:sport, :gender, :season, :active)
        end

    end
end
