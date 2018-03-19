module Api::V1
  class NotificationsController < ApplicationController
    # documentation
    swagger_controller :notifications, "Notification Management"

    swagger_api :index do
      summary "Fetches all Notifications"
      notes "This lists all of the notifications"
    end

    swagger_api :show do
      summary "Shows one Notification"
      params :path, :id, :integer, :required, "Notification ID"
      notes "This lists details of one notification"
      response :not_found
    end

    swagger_api :create do
      summary "Creates a new Notification"
      params :form, :sender_id, :integer, :required, "Sender ID"
      params :form, :receiver_id, :integer, :required, "Receiver ID"
      params :form, :message, :string, :required, "Message"
      params :form, :priority, :string, "Priority"
      response :not_acceptable
    end

    swagger_api :update do
      summary "Updates an existing Notification"
      params :path, :id, :integer, :required, "Notification ID"
      params :form, :sender_id, :integer, :required, "Sender ID"
      params :form, :receiver_id, :integer, :required, "Receiver ID"
      params :form, :message, :string, :required, "Message"
      params :form, :priority, :string, "Priority"
      response :not_found
      response :not_acceptable
    end

    swagger_api :destroy do
      summary "Deletes an existing Notification"
      params :path, :id, :integer, :required, "Notification ID"
      response :not_found
    end

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
      @notification.notified_time = Time.now
      if @notification.save
        render json: @notification, status: :created, location: [:v1, @notification]
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
