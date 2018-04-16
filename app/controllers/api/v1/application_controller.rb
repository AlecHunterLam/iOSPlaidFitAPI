module Api::V1
  class ApplicationController < ActionController::API


    swagger_controller :application, "Application Management"

    swagger_api :token do |api|
      summary "Authenticate with andrew_id and password to get token"
      param :header, "Authorization", :string, :required, "andrew_id and password in the format of: Basic {Base64.encode64('andrew_id:password')}"
    end


    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :authenticate, except: [:token]


    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        @current_user = User.find_by(api_key: token)
      end
    end

    def render_unauthorized(realm = "Application")
      self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
      render json: {error: "Bad Credentials"}, status: :unauthorized
    end


    class << self
        def inherited(subclass)
          super
          subclass.class_eval do
            setup_basic_api_documentation
          end
        end

        private
        def setup_basic_api_documentation
          [:index, :show, :create, :update, :delete].each do |api_action|
            swagger_api api_action do
              param :header, 'Authorization', :string, :required, 'Authentication token in the format of: Token token=<token>'
            end
          end
        end
    end


    include ActionController::HttpAuthentication::Basic::ControllerMethods


    # A method to handle initial authentication
    def token
      authenticate_username_password || render_unauthorized
    end

    protected

    def authenticate_username_password
      authenticate_or_request_with_http_basic do |email, password|
        user = User.authenticate(email, password)
        if user
          render json: user
        end
      end
    end
  end
end
