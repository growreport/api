class SessionsController < ApplicationController
  before_action :authenticate, only: :destroy

  def create
    user = User.find_by_email(params[:email]);
    if user && user.authenticate(params[:password]);
      render json: { auth_token: user.auth_token }
    else 
      render json: { error: "Login invalid" },
        status: :unauthorized
    end
  end

  def destroy
    
  end
end
