class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      redirect_to trips_path
      return
      head :not_found
      return
    end
  end

  def new
    @trip = Trip.new
  end

  def create
    @passenger = Passenger.find_by(id: params[:passenger_id])
    @trip = Trip.new(
    passenger_id: @passenger.id
    )
    @trip.assign_trip
        @trip.save
    redirect_to passenger_path(@trip.passenger.id)
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(trip_params)
      redirect_to passenger_path(@trip.passenger.id)
      return
      render :edit
      return
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    else
      @trip.destroy
      redirect_to homepages_path
      return
    end
  end

  private
  def trip_params
    return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
  end
end
