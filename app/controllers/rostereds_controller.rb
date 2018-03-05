class RosteredsController < ApplicationController

    before_action :set_rostered, only: [:show, :update, :destroy]

    # GET /rostereds
    def index
        @rostereds = Rostered.all
        render json: @rostereds
    end

    # GET /rostereds/1
    def show
        render json: @rostered
    end

    # POST /rostereds
    def create
        @rostered = Rostered.new(rostered_params)
        if @rostered.save
            render json: @rostered, status: :created, location: @rostered
        else
            render json: @rostered.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /rostereds/1
    def update
        if @rostered.update(rostered_params)
            render json: @rostered
        else
            render json: @rostered.errors, status: :unprocessable_entity
        end
    end

    # DELETE /rostereds/1
    def destroy
        @rostered.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_rostered
        @rostered = Rostered.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def rostered_params
        params.permit(:team_id, :user_id)
    end

end

