class Admin::SatellitesController < ApplicationController
  before_action :set_satellite, only: [:show, :edit, :update, :destroy]

  def index
    @satellites = Satellite.includes(:organization).all.order(:name)
  end

  def show
  end

  def new
    @satellite = Satellite.new
  end

  def create
    @satellite = Satellite.new(satellite_params)
    
    if @satellite.save
      redirect_to admin_satellite_path(@satellite), notice: 'Satellite was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @satellite.update(satellite_params)
      redirect_to admin_satellite_path(@satellite), notice: 'Satellite was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @satellite.destroy
    redirect_to admin_satellites_path, notice: 'Satellite was successfully deleted.'
  end

  private

  def set_satellite
    @satellite = Satellite.find(params[:id])
  end

  def satellite_params
    params.require(:satellite).permit(:name, :purpose, :organization_id, :launch_date, :orbit_type, :mass, :dimensions, :power_source, :mission_duration, :status, :image_url, :active)
  end
end
