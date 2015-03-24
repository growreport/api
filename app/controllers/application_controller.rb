class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def authenticate
    head :unauthorized and return if current_user.nil?
  end

  def current_user
    @current_user = User.find_by(auth_token: auth_token) if auth_token
  end

  def auth_token
    authenticate_with_http_token do |token, options|
      @auth_token = token
    end
  end
end
