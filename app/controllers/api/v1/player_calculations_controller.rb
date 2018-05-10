# require './app/services/player_calculation_service_v1.rb'

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
            param :form, :user_id, :integer, :required, "Player ID"
            param :form, :week_of, :date, :required, "Week Of"
            response :not_acceptable
        end

        swagger_api :update do
            summary "Updates an existing Player Calculation"
            param :path, :id, :integer, :required, "Player Calculation ID"
            param :form, :user_id, :integer, :required, "Player ID"
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
            # player_calculation_object = PlayerCalculation.new(user_id: player_calculation_params[:user_id], week_of: player_calculation_params[:week_of])
            # player_calculation_object = PlayerCalculation.new(user_id: player_calculation_params[:user_id], week_of: player_calculation_params[:week_of])

            @player_calculation = get_player_calculation(user_id: player_calculation_params[:user_id], week_of: player_calculation_params[:week_of])

            if @player_calculation.save
                set_relative_rank
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
        # callback to update the season ranks
        # added to system after save, now need to set thte relative rank of the calculation for that week
        def set_relative_rank
          ranked_week_calculations_for_season = PlayerCalculation.for_user(@player_calculation.user_id).rank_by_weekly_load # .for_season(@player_calculation.season)
          i = ranked_week_calculations_for_season.length
          ranked_week_calculations_for_season.each do |calc|
            calc.update(season_rank: i)
            calc.save!
            i = i - 1
          end
          return
        end

        # Use callbacks to share common setup or constraints between actions.
        def set_player_calculation
            @player_calculation = PlayerCalculation.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def player_calculation_params
            params.permit(:user_id, :week_of)
        end


        # service wont work
        def get_player_calculation(partial_calculation_object)
          @season = get_current_season
          @week_of = partial_calculation_object[:week_of]
          @user_id = partial_calculation_object[:user_id]

          @player_calculation = PlayerCalculation.new
          @player_calculation.week_of = @week_of
          @player_calculation.user_id = @user_id
          @player_calculation.season = @season
          # must start on a monday
          if (User.find(@user_id).nil?)
            return nil
          end

          # get start of week/end of week
          start_week = DateTime.new(@player_calculation.week_of.year, @player_calculation.week_of.month, @player_calculation.week_of.day, 0,0,0, @player_calculation.week_of.strftime( "%z" ));
          end_week = DateTime.new(@player_calculation.week_of.year, @player_calculation.week_of.month, @player_calculation.week_of.day, 23,59,59,  @player_calculation.week_of.strftime( "%z" )) + 6;

          all_player_post = Survey.for_user(@player_calculation.user_id).post_practice.surveys_for_week(start_week, end_week)
          all_player_wellness = Survey.for_user(@player_calculation.user_id).daily_wellness.surveys_for_week(start_week, end_week)

          # set daily wellness fields
          sleep_quality_list = []
          sleep_amount_list =[]
          hydration_quality_list = []
          hydration_amount_list = []
          academic_stress_list = []
          life_stress_list = []

          # wellness
          all_player_wellness.each do |s|
            sleep_quality_list << s.quality_of_sleep
            sleep_amount_list << s.hours_of_sleep
            hydration_quality_list << 1 ? s.hydration_quality : hydration_quality_list << 0
            hydration_amount_list << s.ounces_of_water_consumed
            academic_stress_list << s.academic_stress
            life_stress_list << s.life_stress
          end

          @player_calculation.sleep_quality_average = sleep_quality_list.mean
          @player_calculation.sleep_amount_average = sleep_amount_list.mean
          @player_calculation.hydration_quality_average = hydration_quality_list.mean
          @player_calculation.hydration_amount_average = hydration_amount_list.mean
          @player_calculation.academic_stress_average = academic_stress_list.mean
          @player_calculation.life_stress_average = life_stress_list.mean

          # post practice
          daily_load_list = []

          latest_survey = all_player_post.chronological.first
          if latest_survey.nil?
            return nil
          end

          # set params from latest post practice survey
          @player_calculation.weekly_load = latest_survey.weekly_load
          @player_calculation.weekly_strain = latest_survey.weekly_strain
          @player_calculation.week_to_week_weekly_load_percent_change = latest_survey.week_to_week_weekly_load_percent_change
          @player_calculation.monotony = latest_survey.monotony

          player_performance_list = []
          practice_difficulty_average_list = []
          all_player_post.each do |s|
            player_performance_list << s.player_personal_performance
            practice_difficulty_average_list << s.player_rpe_rating

          end

          @player_calculation.practice_difficulty_average = practice_difficulty_average_list.mean
          @player_calculation.personal_performance_average = player_performance_list.mean

          return @player_calculation
        end

        def get_current_season
          current_month = Time.now.month
          current_year = Time.now.year
          current_year = current_year.to_s
          # Fall Season
          if 8 <= current_month && current_month <= 12
            current_seasons = ("Fall-" + current_year)
          end
          if 11 <= current_month || current_month <= 3
            current_seasons = ("Winter-" + current_year)
          end
          if 2 <= current_month && current_month <= 6
            current_seasons = ("Spring-" + current_year)
          end
          if current_seasons == []
            current_seasons = ("Other-" + current_year)
          end
          return current_seasons
        end

    end



end
