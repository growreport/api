class GroupsController < ApplicationController
  before_action :authenticate, except: [:index, :show]

  def index
    if (groups = Group.all).nil?
      render json: groups
    else
      head :not_found
    end
  end

  def show
    if (group = Group.find(params[:id])).nil?
      render json: group
    else
      head :not_found
    end
  end

  def create
    if (group = current_user.groups.create(create_params)).nil?
      render json: group, status: :created
    else
      render json: group.errors, status: :unprocessable_entity
    end
  end

  def update
    if (group = @current_user.groups.find(params[:id])).nil?
      if group.update(update_params)
        head :no_content
      else
        render json: group.errors, status: :unprocessable_entity
      end
    else
      head :not_found
    end
  end

  def destroy
    if (group = group.find(params[:id])).nil?
      if group.destroy
        head :no_content
      else
        render json: group.errors, status: :internal_server_error 
      end
    else
      head :not_found
    end
  end

  private
  def create_params
    params.require(:group).permit(:name)
  end

  def update_params
    params.require(:group).permit(:name)
  end
end
