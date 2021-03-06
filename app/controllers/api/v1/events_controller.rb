module Api::V1
    class EventsController < ApplicationController
      # documentation
      swagger_controller :events, "Events Management"

      swagger_api :index do
        summary "Fetches all Events"
        param :query, :upcoming, :boolean, :optional, "Filters events by upcoming ones"
        notes "This lists all of the events"
      end

      swagger_api :show do
        summary "Shows one Event"
        param :path, :id, :integer, :required, "Event ID"
        notes "This lists details of one event"
        response :not_found
      end

      swagger_api :create do
        summary "Creates a new Event"
        param :form, :user_id, :integer, :required, "Player ID"
        param :form, :event_time, :datetime, :required, "Event Time"
        param :form, :description, :string, :required, "Event Description"
        response :not_acceptable
      end

      swagger_api :update do
        summary "Updates an existing Event"
        param :path, :id, :integer, :required, "Event ID"
        param :form, :user_id, :integer, :optional, "Player ID"
        param :form, :event_time, :datetime, :optional, "Event Time"
        param :form, :description, :string, :optional, "Event Description"
        response :not_found
        response :not_acceptable
      end

      swagger_api :destroy do
        summary "Deletes an existing Event"
        param :path, :id, :integer, :require, "Event ID"
        response :not_found
      end



      before_action :set_event, only: [:show, :update, :destroy]

      # GET /events
      def index
          @events = Event.all
          if (params[:upcoming].present?)
            @events = params[:upcoming] == "true" ? @events.upcoming : @events
          end
          render json: @events
      end

      # GET /events/1
      def show
        render json: @event
      end

      # POST /events
      def create
        @event = Event.new(event_params)
        if @event.save
          render json: @event, status: :created, location: [:v1, @event]
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      # PUT/PATCH /events/1
      def update
        if @event.update(event_params)
          render json: @event
        else
          render json: @event.errors, status: unprocessable_entity
        end
      end

      # DELETE /events/1
      def destroy
        @event.destroy
      end


      private
      # Use callbacks to share common setup or constraints between actions.
      def set_event
        @event = Event.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def event_params
        params.permit(:user_id, :event_time, :description)
      end



    end
end
