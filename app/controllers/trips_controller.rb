class TripsController < ApplicationController
  before_action :require_user

  def show
    # binding.pry
    @trip = TripFacade.trip_by_id(@user.google_id, params[:id])
  end

  def index
    @trips = TripFacade.all_trips(@user.google_id)
  end

  def new
  end

  def create
    new_trip = TripFacade.create_trip(params[:name], @user.google_id,
    params[:departure_date], params[:arrival_date])
    flash[:success] = "You've Created a New Adventure!"
    redirect_to '/trips'
  end

  def destroy
    TripFacade.delete_trip(@user.google_id, params[:id])
    flash[:success] = "Trip has been Cancelled"
    redirect_to '/trips'
  end

  def edit
    @trip = TripFacade.trip_by_id(@user.google_id, params[:id])
  end

  def update
    # @trip = TripFacade.trip_by_id(@user.google_id, params[:id])

    TripFacade.update_trip(params[:id], params[:name], @user.google_id,
    params[:departure_date], params[:arrival_date])
    flash[:success] = "You've Updated Your Adventure"
    redirect_to "/trips/#{params[:id]}"
  end

  private

  def new_trip_params
    params.permit(:name, @user.google_id, :departure_date, :arrival_date)
  end
end
