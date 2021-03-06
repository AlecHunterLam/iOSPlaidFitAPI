module Api::V1
  class UsersController < ApplicationController

    include ActionController::HttpAuthentication::Basic::ControllerMethods
    include ActionController::HttpAuthentication::Token::ControllerMethods
    # documentation

    swagger_controller :users, "User Management"

    swagger_api :index do
      summary "Fetches all Users"
      param :query, :role, :string, :optional, "Filter on which role the user is"
      param :query, :teamID, :integer, :optional, "Filter on which team the user is on"
      param :query, :andrew_id, :string, :optional, "Select the one user with the given Andrew ID"
      param :query, :year, :string, :optional, "Filter on which year the user is"
      param :query, :major, :string, :optional, "Filter on which major the user is"
      notes "Lists all of the users"
    end

    swagger_api :show do
      summary "Shows one User"
      param :path, :id, :integer, :required, "User ID"
      notes "This lists details of one user"
    end

    swagger_api :create do
      summary "Creates a new User"
      param :form, :andrew_id, :string, :required, "Andrew ID"
      param :form, :email, :string, :required, "Email"
      param :form, :major, :string, :required, "Major"
      param :form, :role, :string, :required, "User Role"
      param :form, :first_name, :string, :optional, "First Name"
      param :form, :last_name, :string, :optional,"Last Name"
      param :form, :phone, :string, :optional,"Phone"
      param :form, :password, :password, :required, "Password"
      param :form, :password_confirmation, :password, :required, "Password Confirmation"
      notes "Role must be 'Player', 'Athletic Trainer', 'Coach', or 'Guest'. Major for now is only 'Information Systems', 'Computer Science', or 'Other'."
      response :not_acceptable
    end

    swagger_api :update do
      summary "Updates an existing User"
      param :path, :id, :integer, :required, "User ID"
      param :form, :active, :boolean, :optional,"Active"
      param :form, :andrew_id, :string, :optional, "Andrew ID"
      param :form, :email, :string, :optional, "Email"
      param :form, :major, :string, :optional, "Major"
      param :form, :role, :string, :optional, "User Role"
      param :form, :first_name, :string, :optional,"First Name"
      param :form, :last_name, :string, :optional,"Last Name"
      param :form, :phone, :string, :optional,"Phone"
      param :form, :year, :string, :optional,"Year"
      param :form, :password, :string, :optional,"Password"
      param :form, :password_confirmation, :string, :optional,"Password Confirmation"
      notes "Role must be 'Player', 'Athletic Trainer', 'Coach', or 'Guest'. Major for now is only 'Information Systems', 'Computer Science', or 'Other'."
      response :not_found
      response :not_acceptable
    end

    swagger_api :destroy do
      summary "Deletes an existing User"
      param :path, :id, :integer, :required, "User ID"
      response :not_found
    end



    # callbacks
    before_action :set_user, only: [:show, :update, :destroy]

    # GET /users
    def index
      @users = User.all.active
      if (params[:role].present?)
          @users = @users.by_role(params[:role])
      end
      if (params[:teamID].present?)
          @users = @users.by_team(params[:teamID])
      end
      if (params[:year].present?)
        @users = @users.by_year(params[:year])
      end
      if (params[:major].present?)
        @users = @users.by_major(params[:major])
      end
      if (params[:andrew_id].present?)
          @users = @users.by_andrew_id(params[:andrew_id])
      end

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
      params.permit(:id, :first_name, :last_name, :year, :andrew_id, :email, :major, :phone, :role, :password, :password_confirmation, :active)
    end

  end
end
