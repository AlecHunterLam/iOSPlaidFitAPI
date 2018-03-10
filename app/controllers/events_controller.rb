class EventsController < ApplicationController
  # Controller Code
  before_action :set_event, only: [:show, :update, :destroy]

  # get /events
  def index
    @events = Event.all

    render json: @events
  end

  # get /events/1
  def show
    render json: @event
  end

  # post /event
  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # patch/put /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.erros, status: :unprocessable_entity
    end
  end

  # delete /event/1
  def destroy
    @event.destroy
  end

  private
  # callbacks for common setup
  def set_event
    @event = Event.find(params[:id])
  end

  # white list of parameters
  def event_params
    params.permit(:player_id, :description, :event_time)
  end

end
