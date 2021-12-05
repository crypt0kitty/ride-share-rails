# frozen_string_literal: true
class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    if @driver.nil?
      redirect_to drivers_path
      return
      head :not_found
      return
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)

    if @driver.save
      redirect_to driver_path(@driver)
      return
    else
      render :new
      return
    end
  end

  def edit
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      head :not_found
      return
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      head :not_found
      return
    elsif @driver.update(driver_params)
      redirect_to drivers_path
      return
      render :edit
      return
    end
  end

  def destroy
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      head :not_found
      return
    else
      @driver.destroy
      redirect_to drivers_path
      return
    end
  end

  def set_available
    @driver = Driver.find_by_id(params[:id])
    if @driver.nil?
      head :not_found
      return
    end
    @driver.available = !@driver.available?
    driver = @driver.save
    redirect_to action: :show
  end

    private
  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end

end

