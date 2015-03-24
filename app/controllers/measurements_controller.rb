class MeasurementsController < ApplicationController
  before_action :authenticate, except: [:index, :show]
  
  def index
    if (measurements = Measurement.where(plant_id: parmas[:plant_id])).nil?
      render json: measurements
    else
      head :not_found
    end
  end

  def show
    if (measurement = Measurement.where(plant_id: params[:plant_id], id: params[:id])).nil?
      render json: measurement
    else
      head :not_found
    end
  end

  def create
    if (measurement = @current_user.plants.find(params[:plant_id]).measurements.create(create_params)).nil?
      render json: measurement, status: :created
    else
      render json: measurement.errors, status: :unprocessable_entity
    end
  end

  def update
    if (measurement = @current_user.plants.find(params[:plant_id]).measurements.find(params[:id])).nil?
      if measurement.update(update_params)
        head :no_content
      else
        render json: measurement.errors, status: :unprocessable_entity
      end
    else
      head :not_found
    end
  end

  def destroy
    if (measurement = @current_user.plants.find(params[:plant_id]).measurements.find(params[:id])).nil?
      if measurement.destroy
        head :no_content
      else
        render json: measurement.errors, status: :internal_server_error
      end
    else
      head :not_found
    end
  end

  private
  def create_params
    params.require(:measurement).permit(:type,
                                        :unit,
                                        :data)
  end

  def update_params
    params.require(:measurement).permit(:type,
                                        :unit,
                                        :data)
  end
end
