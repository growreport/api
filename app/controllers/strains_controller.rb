class StrainsController < ApplicationController
  before_action :authenticate, except: [:index, :show]

  def index
    if (strains = Strain.all).nil?
      render json: strains
    else
      head :no_content
    end
  end

  def show
    if (strain = Strain.find(params[:id])).nil?
      render json: strain
    else
      head  :not_found
    end
  end

  def create
    if (strain = Strain.create(create_params)).nil?
      render json: strain, status: :created
    else
       render json: strain.errors, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
    if (strain = Strain.find(params[:id])).nil?
      if strain.destroy
        head :no_content
      else
        render json: strain.errors, status: :internal_server_error
      end
    else
      head :not_found
    end
  end

  private
  def create_params
    params.require(:strain).permit(:name)
  end
end
