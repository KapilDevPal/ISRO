class Admin::LaunchesController < ApplicationController
  before_action :set_launch, only: [:show, :edit, :update, :destroy]

  def index
    @launches = Launch.includes(:rocket, :satellites).all.order(launch_date: :desc)
  end

  def show
  end

  def new
    @launch = Launch.new
  end

  def create
    @launch = Launch.new(launch_params)
    
    if @launch.save
      redirect_to admin_launch_path(@launch), notice: 'Launch was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @launch.update(launch_params)
      redirect_to admin_launch_path(@launch), notice: 'Launch was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @launch.destroy
    redirect_to admin_launches_path, notice: 'Launch was successfully deleted.'
  end

  private

  def set_launch
    @launch = Launch.find(params[:id])
  end

  def launch_params
    params.require(:launch).permit(:name, :launch_date, :launch_site, :status, :outcome, :mission_objective, :rocket_id, satellite_ids: [])
  end
end
