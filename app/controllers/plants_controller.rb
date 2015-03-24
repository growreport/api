class PlantsController < ApplicationController
  before_action :authenticate, except: [:index, :show]

  def index
    if (plants = Plant.all).nil?
      render json: plants
    else
      head :not_found
    end
  end

  def show
    if (plant = Plant.find(params[:id])).nil?
      render json: plant
    else
      head :not_found
    end
  end

  def create
    if (plant = @current_user.plants.create(create_params)).nil?
      render json: plant, status: :created
    else
      render json: plant.errors, status: :unprocessable_entity
    end
  end

  def update
    if (plant = @current_user.plants.find(params[:id])).nil?
      if plant.update(update_params)
        head :no_content
      else
        render json: plant.errors, status: :unprocessable_entity
      end
    else
      head :not_found
    end
  end

  def destroy
    if (plant = @current_user.plants.find(params[:id])).nil?
      if plant.destroy
        head :no_content
      else
        render json: plant.errors, status: :internal_server_error 
      end
    else
      head :not_found
    end
  end

  private
  def create_params
    params.require(:plant).permit(:age)
  end

  def update_params
    params.require(:plant).permit(:age,
                                  :harvest_date,
                                  :cure_date)
  end
end
