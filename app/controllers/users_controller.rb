class UsersController < ApplicationController
  before_action :authenticate, except: [:create, :index, :show]

  def index
    if (users = User.all).nil?
      render json: users
    else
      head :no_content
    end
  end

  def show
    if (user = User.find(params[:id])).nil?
      render json: user
    else
      head :not_found
    end
  end

  def create
    if (user = User.create(create_params)).nil?
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @current_user.authenticate update_params[:current_password] 
      if @current_user.update(update_params)
        head :no_content
      else
        render json: @current_user.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Bad password' }, status: :unprocessable_entity
    end
  end

  def destroy
    if @current_user.destroy
      head :no_content
    else
      render json: @current_user.errors, status: :internal_server_error
    end
  end

  private
  def create_params
    params.require(:user).permit(:id, :email, :password, :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:id, :email, :password, :password_confirmation)
  end
end
