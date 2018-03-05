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
        param :form, :type, :string, :required, "Type"
        param :form, :response, :string, :required, "Response"
        param :form, :season, :string, :required, "Season"
        param :form, :completed, :date, :required, "Completed Date"
        response :not_acceptable
    end

    swagger_api :update do
        summary "Updates an existing Survey"
        param :path, :id, :integer, :required, "Survey ID"
        param :path, :user_id, :integer, :required, "User ID"
        param :form, :type, :string, :optional, "Type"
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
        @survey = Survey.new(survey_params)
        if @survey.save
            render json: @survey, status: :created, location: @survey
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
        params.permit(:type, :user_id, :response, :completed, :season)
    end

end

