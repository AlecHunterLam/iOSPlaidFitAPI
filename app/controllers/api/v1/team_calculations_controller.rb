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
            @team_calculation = get_team_calculation_object(team_id: team_calculation_params[:team_id], week_of: team_calculation_params[:week_of])

            if @team_calculation.save!
                set_relative_rank_team
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

        def set_relative_rank_team
          ranked_week_calculations_for_season = TeamCalculation.for_team(@team_calculation.team_id).rank_by_weekly_load #.for_season(@team_calculation.season)
          i = ranked_week_calculations_for_season.length
          ranked_week_calculations_for_season.each do |calc|
            calc.update(season_rank: 1)
            calc.save!
            i = i - 1
          end
          return
        end

        # Use callbacks to share common setup or constraints between actions.
        def set_team_calculation
            @team_calculation = TeamCalculation.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def team_calculation_params
            params.permit(:team_id, :week_of)
        end


        def get_team_calculation_object(params)
          @team_id = params[:team_id]
          @week_of = params[:week_of]


          @team_calculation = TeamCalculation.new
          team = Team.find(@team_id)
          @team_calculation.season = team.season.to_s + "-" + (Time.now.year).to_s
          @team_calculation.week_of = params[:week_of]

          if (Team.find(@team_id).nil?)
            return nil
          end

          start_week = DateTime.new(@team_calculation.week_of.year, @team_calculation.week_of.month, @team_calculation.week_of.day, 0,0,0, @team_calculation.week_of.strftime( "%z" ));

          @team_calculation.week_of = start_week
          @team_calculation.team_id = @team_id

          all_player_calc = []
          all_players_for_team = User.all.by_team(@team_id).by_role("Player")
          all_players_for_team.each do |user|
            all_player_calc << PlayerCalculation.all.for_user(user.id).for_week(@team_calculation.week_of)
          end

          weekly_load_list = []
          weekly_strain_list = []
          life_stress_average_list = []
          academic_stress_average_list = []
          sleep_quality_average_list = []
          hydration_quality_average_list = []
          practice_difficulty_average_list = []
          team_monotony_list = []
          week_to_week_weekly_load_percent_change_list = []
          sleep_amount_average_list = []
          hydration_amount_average_list = []


          all_player_calc.each do |pc|
            if !(pc.blank?)
              pc = pc.first
              puts pc
              weekly_load_list << pc.weekly_load
              weekly_strain_list << pc.weekly_strain
              life_stress_average_list << pc.life_stress_average
              academic_stress_average_list << pc.academic_stress_average
              sleep_quality_average_list << pc.sleep_quality_average
              hydration_quality_average_list << pc.hydration_quality_average
              practice_difficulty_average_list << pc.practice_difficulty_average
              team_monotony_list << pc.monotony
              week_to_week_weekly_load_percent_change_list << pc.week_to_week_weekly_load_percent_change
              sleep_amount_average_list << pc.sleep_amount_average
              hydration_amount_average_list << pc.hydration_amount_average
            end
          end

          @team_calculation.weekly_load = weekly_load_list.mean
          @team_calculation.weekly_strain = weekly_strain_list.mean
          @team_calculation.life_stress_average = life_stress_average_list.mean
          @team_calculation.academic_stress_average = academic_stress_average_list.mean
          @team_calculation.sleep_quality_average = sleep_quality_average_list.mean
          @team_calculation.hydration_quality_average = hydration_quality_average_list.mean
          @team_calculation.practice_difficulty_average = practice_difficulty_average_list.mean
          @team_calculation.team_monotony = team_monotony_list.mean
          @team_calculation.week_to_week_weekly_load_percent_change = week_to_week_weekly_load_percent_change_list.mean
          @team_calculation.sleep_amount_average = sleep_amount_average_list.mean
          @team_calculation.hydration_amount_average = hydration_amount_average_list.mean

          return @team_calculation
        end

    end
end
