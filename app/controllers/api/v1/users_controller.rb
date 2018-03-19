module Api::V1
  class UsersController < ApplicationController
    # documentation

    swagger_controller :users, "User Management"

    swagger_api :index do
      summary "Fetches all Users"
      notes "Lists all of the users"
    end

    swagger_api :show do
      summary "Shows one User"
      params :path, :id, :integer, :required, "User ID"
      notes "This lists details of one user"
    end

    swagger_api :create do
      summary "Creates a new User"
      params :form, :andrew_id, :string, :required, "Andrew ID"
      params :form, :email, :string, :required, "Email"
      params :form, :major, :string, :required, "Major"
      parmas :form,



      params.permit(:first_name, :last_name, :team_id, :andrew_id, :email, :major, :phone, :role)
      validates_presence_of :andrew_id, :email, :major, :role, :active


    # callbacks
    before_action :set_user, only: [:show, :update, :destroy]

    # GET /users
    def index
      @users = User.all
      render json: @users
    end

    # GET /users/1
    def show
      render json: @user
    end

    # POST /users
    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created, location: [:v1, @user]
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PUT/PATCH /users/1
    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # DELETE /users/1
    def destroy
      @user.destroy
    end

    private
    # set the user object
    def set_user
      @user = User.find(params[:id])
    end

    # whitelist parameters for a user to input and create/update
    def user_params
      # should only allow role if the current user is an admin. Leaving it like this for now, will come back to this.
      params.permit(:first_name, :last_name, :andrew_id, :email, :major, :phone, :role)
    end




  end
end
