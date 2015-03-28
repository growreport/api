class UsersController < ApplicationController
  before_action :authenticate, except: [:create, :index, :show]

  def index
    users = User.all
    if users
      render json: users
    else
      head :no_content
    end
  end

  def show
    user = User.find(params[:id])
    if user.valid?
      render json: user
    else
      head :not_found
    end
  end

  def create
    user = User.create(create_params)
    if user.valid? 
      render json: user, status: :created
    else
      render json: { 
        error: user.errors.messages 
      }, status: :unprocessable_entity
    end
  end

  def update
    if @current_user.authenticate update_params[:current_password] 
      params = update_params.except(:current_password)
      if @current_user.update(params)
        head :no_content
      else
        render json: u.errors, status: :unprocessable_entity
      end
    else
      render json: { error: { current_password: 'Incorrect' } }, status: :unprocessable_entity
    end
  end

  def destroy
    if @current_user.delete
      head :no_content
    else
      render json: @current_user.errors, status: :internal_server_error
    end
  end

  private
  def create_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:email, :username, :current_password, :password, :password_confirmation) 
  end
end
