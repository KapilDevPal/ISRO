class Admin::RocketsController < ApplicationController
  before_action :set_rocket, only: [:show, :edit, :update, :destroy]

  def index
    @rockets = Rocket.includes(:organization).all.order(:name)
  end

  def show
  end

  def new
    @rocket = Rocket.new
  end

  def create
    @rocket = Rocket.new(rocket_params)
    
    if @rocket.save
      redirect_to admin_rocket_path(@rocket), notice: 'Rocket was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @rocket.update(rocket_params)
      redirect_to admin_rocket_path(@rocket), notice: 'Rocket was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @rocket.destroy
    redirect_to admin_rockets_path, notice: 'Rocket was successfully deleted.'
  end

  private

  def set_rocket
    @rocket = Rocket.find(params[:id])
  end

  def rocket_params
    params.require(:rocket).permit(:name, :description, :organization_id, :height, :mass, :diameter, :stages, :cost_per_launch, :success_rate, :image_url, :active)
  end
end
