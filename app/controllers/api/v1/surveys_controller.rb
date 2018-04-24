require './app/services/survey_service_v2.rb'

module Api::V1
    class SurveysController < ApplicationController

        swagger_controller :surveys, "Surveys Management"

        swagger_api :index do
            summary "Fetches all Surveys"
            notes "This lists all the Surveys"
        end

        swagger_api :show do
            summary "Shows one Survey"
            param :path, :id, :integer, :required, "Survey ID"
            notes "This lists details of one survey"
            response :not_found
        end

        swagger_api :create do
            summary "Creates a new Survey"
            param :form, :user_id, :integer, :required, "User ID"
            param :form, :survey_type, :string, :required, "survey_type"
            param :form, :response, :string, :required, "Response"
            param :form, :season, :string, :required, "Season"
            param :form, :completed, :date, :required, "Completed Date"
            response :not_acceptable
        end

        swagger_api :update do
            summary "Updates an existing Survey"
            param :path, :id, :integer, :required, "Survey ID"
            param :path, :user_id, :integer, :required, "User ID"
            param :form, :survey_type, :string, :optional, "survey_type"
            param :form, :response, :string, :optional, "Response"
            param :form, :season, :string, :optional, "Season"
            param :form, :completed, :date, :optional, "Completed Date"
            response :not_found
            response :not_acceptable
        end

        swagger_api :destroy do
            summary "Deletes an existing Survey"
            param :path, :id, :integer, :required, "Survey ID"
            response :not_found
        end

        before_action :set_survey, only: [:show, :update, :destroy]

        # GET /surveys
        def index
            @surveys = Survey.all
            render json: @surveys
        end

        # GET /surveys/1
        def show
            render json: @survey
        end

        # POST /surveys
        def create
          if survey_params[:datetime_today].nil?
            survey_params[:datetime_today] = Time.now
          end
          survey_service_object = Survey.new(survey_params)
          @survey = survey_service_object.get_survey_object
          if @survey.save
              render json: @survey, status: :created, location: [:v1, @survey]
          else
              render json: @survey.errors, status: :unprocessable_entity
          end
        end

        # PATCH/PUT /surveys/1
        def update
            if @survey.update(survey_params)
                render json: @survey
            else
                render json: @survey.errors, status: :unprocessable_entity
            end
        end

        # DELETE /surveys/1
        def destroy
            @survey.destroy
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_survey
            @survey = Survey.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def survey_params
            params.permit(:user_id, :team_id, :practice_id, :survey_type,
                          :datetime_today, :player_rpe_rating,
                          :player_personal_performance,
                          :participated_in_full_practice,
                          :minutes_participated,
                          :participated_in_full_practice, :completed, :season,
                          :hours_of_sleep, :quality_of_sleep, :academic_stress,
                          :life_stress, :soreness, :ounces_of_water_consumed,
                          :hydration_quality)
        end

    end
end
