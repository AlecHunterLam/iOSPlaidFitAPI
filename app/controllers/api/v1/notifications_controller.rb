module Api::V1
  class NotificationsController < ApplicationController
    before_action :set_notification, only: [:show, :update, :destroy]

    # GET /notifications
    def index
      @notifications = Notification.all
      render json: @notifications
    end

    # GET /notifications/1
    def show
      render json: @notification
    end

    # POST /notifications
    def create
      @notification = Notification.new(notification_params)
      if @notification.save
        render json: @notification, status: :created, location: [:v1, @event]
      else
        render json: @notification.errors, status: :unprocessable_entity
      end
    end

    # PUT/PATCH /notifications/1
    def update
      if @notification.update(notification_params)
        render json: @notification
      else
        render json: @notification.errors, status: :unprocessable_entity
      end
    end

    # DELETE /notifications/1
    def destroy
      @notification.destroy
    end

    private

    # set the notification object before the method is called
    def set_notification
      @notification = Notification.find(params[:id])
    end

    def notification_params
      # should sender ID be the current logged in user? (current_user)
      params.permit(:sender_id, :receiver_id, :priority, :message)
    end



  end
end
