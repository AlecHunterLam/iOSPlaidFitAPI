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
      param :form, :user_id, :integer, :required, "Sender ID"
      notes "This lists notifications for a specific user"
      response :not_found
    end

    swagger_api :create do
      summary "Creates a new Notification"
      param :form, :user_id, :integer, :required, "Sender ID"
      param :form, :receiver_id, :integer, :required, "Receiver ID"
      param :form, :message, :string, :required, "Message"
      param :form, :priority, :string, "Priority"
      response :not_acceptable
    end

    swagger_api :update do
      summary "Updates an existing Notification"
      param :path, :id, :integer, :required, "Notification ID"
      param :form, :user_id, :integer, :optional, "Sender ID"
      param :form, :receiver_id, :integer, :optional, "Receiver ID"
      param :form, :message, :string, :optional, "Message"
      param :form, :priority, :string, :optional, "Priority"
      response :not_found
      response :not_acceptable
    end

    swagger_api :destroy do
      summary "Deletes an existing Notification"
      param :path, :id, :integer, :required, "Notification ID"
      response :not_found
    end

    before_action :set_notification, only: [:show, :update, :destroy]

    # GET /notifications
    def index
      @notifications = Notification.all
      render json: @notifications
    end

    # GET /notifications/ => user_id = number
    def show
      @notifications_for_user = Notification.for_user(params[:user_id])
      render json: @notifications_for_user
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
      params.permit(:user_id, :receiver_id, :priority, :message)
    end



  end
end
