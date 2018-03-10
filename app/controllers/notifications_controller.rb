class NotificationsController < ApplicationController
  # Controller Code
  before_action :set_notification, only: [:show, :update, :destroy]

  # get /notifications
  def index
    @notifications = Notification.all

    render json: @notifications
  end

  # get /notifications/1
  def show
    render json: @notification
  end

  # post /notification
  def create
    @notification = Notification.new(notification_params)

    # set notification time
    @notification.notified_time = Time.now

    if @notification.save
      render json: @notification, status: :created, location: @notification
    else
      render json: @notification.errors, status: :unprocessable_entity
    end
  end

  # patch/put /notifications/1
  def update
    if @notification.update(notification_params)
      render json: @notification
    else
      render json: @notification.errors, status: :unprocessable_entity
    end
  end

  # delete /notification/1
  def destroy
    @notification.destroy
  end

  private
  # callbacks for common setup
  def set_notification
    @notification = Notification.find(params[:id])
  end

  # white list of parameters
  def notification_params
    params.permit(:sender_id, :receiver_id, :priority, :message, :active)
  end

end
