module Api::V1
    class TeamAssignmentsController < ApplicationController

        swagger_controller :team_assignments, "Team Assignments Management"

        swagger_api :index do
            summary "Fetches all Team Assignments"
            notes "This lists all the Team Assignments"
        end

        swagger_api :show do
            summary "Shows one Team Assignment"
            param :path, :id, :integer, :required, "Team Assignment ID"
            notes "This lists details of one team assignment"
            response :not_found
        end

        swagger_api :create do
            summary "Creates a new Team Assignment"
            param :form, :team_id, :integer, :required, "Team ID"
            param :form, :user_id, :integer, :required, "User ID"
            response :not_acceptable
        end

        swagger_api :update do
            summary "Updates an existing Team Assignment"
            param :path, :id, :integer, :required, "Team Assignment ID"
            param :path, :team_id, :integer, :required, "Team ID"
            param :path, :user_id, :integer, :required, "User ID"
            response :not_found
            response :not_acceptable
        end

        swagger_api :destroy do
            summary "Deletes an existing Team Assignment"
            param :path, :id, :integer, :required, "Team Assignment ID"
            response :not_found
        end

        before_action :set_team_assignment, only: [:show, :update, :destroy]

        # GET /team_assignments
        def index
            @team_assignments = TeamAssignment.all
            render json: @team_assignments
        end

        # GET /team_assignments/1
        def show
            render json: @team_assignment
        end

        # POST /team_assignments
        def create
            @team_assignment = TeamAssignment.new(team_assignment_params)
            if @team_assignment.save
                render json: @team_assignment, status: :created, location: [:v1, @team_assignment]
            else
                render json: @team_assignment.errors, status: :unprocessable_entity
            end
        end

        # PATCH/PUT /team_assignments/1
        def update
            if @team_assignment.update(team_assignment_params)
                render json: @team_assignment
            else
                render json: @team_assignment.errors, status: :unprocessable_entity
            end
        end

        # DELETE /team_assignments/1
        def destroy
            @team_assignment.destroy
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_team_assignment
            @team_assignment = TeamAssignment.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def team_assignment_params
            params.permit(:team_id, :user_id, :active, :date_added)
        end

    end
end
